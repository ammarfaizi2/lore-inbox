Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWCZQLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWCZQLg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWCZQLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:11:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6924 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751386AbWCZQLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:11:35 -0500
Date: Sun, 26 Mar 2006 18:10:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: smp_locks reference_discarded errors
Message-ID: <20060326161055.GA4584@mars.ravnborg.org>
References: <20060325033948.GA15564@redhat.com> <20060325235035.5fcb902f.akpm@osdl.org> <20060326154042.GB13684@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326154042.GB13684@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 10:40:42AM -0500, Dave Jones wrote:
> On Sat, Mar 25, 2006 at 11:50:35PM -0800, Andrew Morton wrote:
>  > Dave Jones <davej@redhat.com> wrote:
>  > >
>  > > since the addition of smp alternatives, the following is occuring..
>  > > 
>  > > Error: ./drivers/md/md.o .smp_locks refers to 0000008c R_386_32          .exit.text
>  > > Error: ./drivers/usb/storage/libusual.o .smp_locks refers to 00000008 R_386_32          .exit.text
>  > > Error: ./net/802/psnap.o .smp_locks refers to 00000000 R_386_32          .exit.text
>  > > Error: ./drivers/pci/hotplug/ibmphp_hpc.o .smp_locks refers to 00000008 R_386_32          .exit.text
>  > > Error: ./drivers/pci/hotplug/ibmphp_hpc.o .smp_locks refers to 0000000c R_386_32          .exit.text
>  > > 
>  > > example .config at http://people.redhat.com/davej/kernel-2.6.16-i686-smp.config
>  > > 
>  > 
>  > I guess an atomic operation in __exit code will cause that.  down() and
>  > atomic_dec_and_test() in two cases.
>  > 
>  > I suspect most of these callsites are just wrongly coded - it's pretty
>  > unusual for __exit code to really need to lock anything - what is there to
>  > be racing against?
>  > 
>  > This is emitted by reference_discarded.pl?
> 
> came out of a 'make buildcheck' a day or two ago (the following day,
> Sam nuked reference_discarded.pl in favour of it being done
> magically somewhere else (I've not looked into how its done now).
The check is part of modpost now. modpost is only used when building
modules but that holds true for most builds anyway therefore I did not
move it to a separate executable.

Also the output from modpost provides a bit more info.
So output from fresh -linus kernel would make it easier to locate the
guilty stuff.

	Sam
