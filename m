Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVKCGrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVKCGrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 01:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVKCGrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 01:47:15 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:49103 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1751140AbVKCGrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 01:47:15 -0500
Date: Thu, 3 Nov 2005 07:47:27 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs for /dev/console with udev?
Message-ID: <20051103064727.GR23316@pengutronix.de>
References: <20051102222030.GP23316@pengutronix.de> <200511022140.25268.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200511022140.25268.rob@landley.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 09:40:24PM -0600, Rob Landley wrote:
> > dir /dev 0755 0 0
> > nod /dev/console 0600 0 0 c 5 1
> > nod /dev/null 0600 0 0 c 1 3
> > dir /root 0700 0 0
> >
> > and let CONFIG_INITRAMFS_SOURCE point to that file. The gpio archive is
> > built correctly with that, but my kernel doesn't seem to use it.
> 
> 1) You have no init in initramfs, so it goes ahead and mounts whatever root= 
> points to over it. I'm guessing that's where it's looking for /dev/console 
> from.

Hmm, I thought something like that. That means that I do need a complete
klibc based early userspace, just to get these two device nodes? Seems
like I'll have to do some deeper investigation of klibc; last time I
looked it didn't even compile for ARCH=um.  

> 2) What's the directory /root for?

Just a relict from the default script; the first three lines should be
enought. But it shouldn't matter. 

> > Is anything else needed to use an initrd, like a command line argument?
> > My kernel boots from a nfs partition, so it sets nfsroot=...
> 
> Note that initramfs and initrd and very different things.

Is there any other known possibility to get just these two device nodes
in an automatic way? I'm trying to get rid of devfs, and udev works just
fine. The only thing not solved yet is how to get the beast started
without /dev/console and /dev/null. I don't want to create the nodes
statically, because that's only possible with root permissions. 

Some background: I'm building root filesystems for embedded systems with
PTXdist; the user is able to build the whole thing without root
permissions; either with a cross compiler and mount it via NFS or build
a JFFS2 image, or, with one switch, build and run it with an uml kernel.

I also tried ndevfs, just to get these two nodes, but I didn't find out
how to automatically mount it on boot yet. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

