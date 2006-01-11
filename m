Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751714AbWAKSkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWAKSkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWAKSkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:40:12 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:51181 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751714AbWAKSkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:40:10 -0500
Date: Wed, 11 Jan 2006 19:40:28 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)
Message-ID: <20060111184027.GB4735@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	reiserfs-dev@namesys.com, linux-acpi@vger.kernel.org
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <15632.83.103.117.254.1136989660.squirrel@picard.linux.it> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060111100016.GC2574@elf.ucw.cz> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15632.83.103.117.254.1136989660.squirrel@picard.linux.it> <20060111100016.GC2574@elf.ucw.cz> <20060110170037.4a614245.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-rc5-mm3-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I gave -mm3 a run:

On Tue, Jan 10, 2006 at 05:00:37PM -0800, Andrew Morton wrote:
> Mattia Dongili <malattia@linux.it> wrote:
[...]
> > 1- reiser3 oopsed[1] twice while suspending to ram. It seems
> >    reproducible (have some activity on the fs and suspend)
> 
> No significant reiser3 changes in there, so I'd be suspecting something
> else has gone haywire.

It's still there. But I caught it during normal runtime, a couple more
pictures (yes, I'm going to try to setup a netconsole):

the oops (sorry, it sucks, probably useless):
http://oioio.altervista.org/linux/dsc03136.jpg

a screen with the call traces, the keyboard was still active and sysrq
combos worked. It showed many processes stuck within reiser's log writer:
http://oioio.altervista.org/linux/dsc03138.jpg

going to revert the 

> > 3- This laptop experienced 2 long stalls (20~25 sec) during boot,
> >    apparently after scanning usb_storage devices and starting portmap.

umph... it's still here call traces:
http://oioio.altervista.org/linux/portmap_stall_trace1

[...]
> There's not much point in fiddling with -mm2.  If git7 is OK then please
> test the next -mm and if it still fails then yes, doing a bisection would
> really help.
> 
> <types madly>
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

give me some hours for this.
Anyway I'd like to try to revert some reiser3 changes first and see if
the oops goes (I can leave with a longer boot but I'm worried about my
root fs :))

> > 4- I'm also affected by the ACPI Misaligned resource pointer error.

still here:
# grep -e 'Jan 11.*Misaligned.*' /var/log/syslog
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cff4b7e2 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cff4b7e2 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cff4b2e2 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cf657902 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cf657602 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cf657402 Type 07 Len 0
Jan 11 18:07:10 inferi kernel: **** SET: Misaligned resource pointer: cf657402 Type 07 Len 0
Jan 11 18:18:53 inferi kernel: **** SET: Misaligned resource pointer: cf657d02 Type 07 Len 0
Jan 11 18:21:14 inferi kernel: **** SET: Misaligned resource pointer: cf657d02 Type 07 Len 0

DSDT and lspci can be found here if useful:
http://oioio.altervista.org/linux/DSDT.aml
http://oioio.altervista.org/linux/DSDT.dsl
http://oioio.altervista.org/linux/lspci-v

On Wed, Jan 11, 2006 at 11:00:16AM +0100, Pavel Machek wrote:
[...]
> > > 1- reiser3 oopsed[1] twice while suspending to ram. It seems
> > >    reproducible (have some activity on the fs and suspend)
[...]
> Suspend to *RAM*? That really does not do anything that should kill

Sorry, it seems it has nothing to do with s2ram.

-- 
mattia
:wq!
