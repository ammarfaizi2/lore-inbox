Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTEPJOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 05:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTEPJOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 05:14:30 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:50897 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264393AbTEPJO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 05:14:28 -0400
Date: Fri, 16 May 2003 11:27:08 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Pavel Roskin <proski@gnu.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       Jean Tourrilhes <jt@hpl.hp.com>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030516092708.GC16156@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030515200324.GB12949@ranty.ddts.net> <Pine.LNX.4.55.0305151623520.2885@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0305151623520.2885@marabou.research.att.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 04:38:58PM -0400, Pavel Roskin wrote:
> On Thu, 15 May 2003, Manuel Estrada Sainz wrote:
> 
> >  This time, as Greg suggested, it is implemented on top of 'struct
> >  class' and 'struct class_device' but the driver interface is the same
> >  as last time.
> 
> Nitpicking:
> 
> - Please use max_t, not your own MAX.

 I was really wondering why MAX/MIN had not being generalized :)

> - /s/jet/yet/g
> - firmware_loading_show() should be static

 All three fixed. 
 
 
> >  	- register_firmware can not be implemented without some form of
> > 	  in-kernel firmware caching. And that is not implemented.
> 
> I wrote this private already, but it needs to be said now.  It's not
> _caching_ that is needed.  What is needed is a filesystem that can be
> populated in the kernel binary.

 I don't know that much about initramfs, but how about, firmware images
 get included in the initramfs and copied into fwfs during early
 userspace?

 I'll call it 'persistence' instead of 'caching' from now on.
 
 And I guess that 'blobfs' would be a much better name than 'fwfs'.
 Meaning that it can be used to store any blob.

> Can I use this code to replace broken ACPI table (DSDT) I have in some of
> my systems?  Can I use this code to load firmware into my SCSI adapter if
> I need it to access the only disk in the system?  Can I use this code to
> program a network interface I'm going to use for root over NFS?

 The interface would allow it, but some kind of persistence has to be
 there to make it possible. 
 
> > 	- fwfs could be used for firmware caching behind the scene
> > 	  allowing register_firmware to be implemented and the other
> > 	  uses. I could call it blobfs and make a subdirectory within
> > 	  for firmware purposes.
> 
> I don't understand that, but I admit that it may be the answer to my
> question.  Again, "caching" is a wrong word, I believe.

 - Rename 'fwfs' into 'blobfs'
 - Use it as the persistence mechanism behind request_firmware()
 - Use one level of hierarchy within the filesystem:
 	$BLOBFS_MNT/firmware/...
	$BLOBFS_MNT/crypto_keys/...
	...
   I don't know if it would really be useful for crypto keys, but it
   looked like a good sample :)

   request_firmware() would then just search with in
   $BLOBFS_MNT/firmware/

 Regards

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
