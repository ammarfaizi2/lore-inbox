Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWBMXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWBMXbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWBMXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:31:32 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:22495 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1030276AbWBMXbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:31:31 -0500
Date: Tue, 14 Feb 2006 00:31:14 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml@rtr.ca, dgc@sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Message-ID: <20060213233114.GA21971@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, lkml@rtr.ca, dgc@sgi.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org> <43E75ED4.809@rtr.ca> <43E75FB6.2040203@rtr.ca> <20060206121133.4ef589af.akpm@osdl.org> <20060213135925.GA6173@linuxtv.org> <20060213120847.79215432.akpm@osdl.org> <20060213224835.GC5565@linuxtv.org> <20060213150457.547ddfb4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213150457.547ddfb4.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.189.220.130
Subject: Re: dirty pages (Was: Re: [PATCH] Prevent large file writeback starvation)
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 03:04:57PM -0800, Andrew Morton wrote:
> Johannes Stezenbach <js@linuxtv.org> wrote:
> >
> > On Mon, Feb 13, 2006, Andrew Morton wrote:
> >  > Johannes Stezenbach <js@linuxtv.org> wrote:
> >  > > Now copying a 700MB file makes "Dirty" go up to 350MB. It then
> >  > > slowly decreases to 325MB and stays there.
> >  > 
> >  > It shouldn't.  Did you really leave it for long enough?
> >  > 
> >  > If you did, then why does it happen there and not here?
> > 
> >  Good question. I just repeated the execise, rebooted and
> >  copied a 700MB file. After ~30min "Dirty" is down to ~130MB, and
> >  continues to decrease very slowly.
> > 
> >  On my Desktop machine (P4 HT, 1G RAM) "Dirty" goes down near
> >  zero after ~30sec, as expected.
> 
> Are you using any unusual mount options?
> 
> Which filesystem types are online (not that this should affect it...)

$ cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw,data=ordered 0 0
proc /proc proc rw,nodiratime 0 0
sysfs /sys sysfs rw 0 0
usbfs /proc/bus/usb usbfs rw 0 0
/dev/root /dev/.static/dev ext3 rw,data=ordered 0 0
tmpfs /dev tmpfs rw 0 0
tmpfs /dev/shm tmpfs rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/hda6 /home ext3 rw,data=ordered 0 0
nfsd /proc/fs/nfsd nfsd rw 0 0
$

I found that if I copy a large number of small files (e.g. the linux
source tree), "Dirty" drops back near zero after ~30sec. Only if
I copy large files it won't.


Johannes
