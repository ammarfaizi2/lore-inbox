Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbUJWUiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUJWUiY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUJWUh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:37:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16135 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261301AbUJWUgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:36:19 -0400
Date: Sat, 23 Oct 2004 21:36:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1 initramfs busted [u]
Message-ID: <20041023213611.A29087@flint.arm.linux.org.uk>
Mail-Followup-To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20041023133120.A28178@flint.arm.linux.org.uk> <1098535328.668.13.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1098535328.668.13.camel@nosferatu.lan>; from azarah@nosferatu.za.org on Sat, Oct 23, 2004 at 02:42:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 02:42:08PM +0200, Martin Schlemmer [c] wrote:
> On Sat, 2004-10-23 at 13:31 +0100, Russell King wrote:
> > A build using O= does this:
> > 
> >   HOSTCC  usr/gen_init_cpio
> >   GEN_INITRAMFS_LIST usr/initramfs_list
> > Using shipped usr/initramfs_list
> >   CPIO    usr/initramfs_data.cpio
> > ERROR: unable to open 'usr/initramfs_list': No such file or directory
> > 
> > Usage:
> >         ./usr/gen_init_cpio <cpio_list>
> > 
> > <cpio_list> is a file containing newline separated entries that
> > describe the files to be included in the initramfs archive:
> > 
> > The source tree contains this in usr:
> > 
> > -rw-r--r--  1 rmk rmk 1657 Oct 23 11:41 Makefile
> > -rw-r--r--  1 rmk rmk 8335 Oct 23 11:41 gen_init_cpio.c
> > -rw-r--r--  1 rmk rmk 1024 Aug  1  2003 initramfs_data.S
> > -rw-r--r--  1 rmk rmk  146 Oct 23 11:41 initramfs_list
> > 
> > and the build tree usr contains:
> > 
> > -rwxr-xr-x  1 rmk rmk 10834 Oct 23 13:29 gen_init_cpio
> > -rw-r--r--  1 rmk rmk     0 Oct 23 13:29 initramfs_data.cpio
> > 
> > Running with V=1 shows:
> > 
> > make -f /home/rmk/build/linux-v2.6-local/scripts/Makefile.build obj=usr
> >   echo Using shipped usr/initramfs_list
> > Using shipped usr/initramfs_list
> >   ./usr/gen_init_cpio usr/initramfs_list > usr/initramfs_data.cpio
> > ERROR: unable to open 'usr/initramfs_list': No such file or directory
> > 
> > so it's referencing the wrong directory.
> > 
> 
> Yep.  Please see the
> 
>  [PATCH 2.6.9-bk7] Select cpio_list or source directory for initramfs image updates
> 
> thread for latest patch to fix this and other issues.  There are some
> other patches floating around that is slightly smaller, but I would
> appreciate testing and feedback.

There's this obvious error in the patch (missing 'i'):

+$(obj)/$(initramfs_list): FORCE
+	$(if $(nitramfs_list_state_uptodate),, \

though I am wondering why this looks rather complicated.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
