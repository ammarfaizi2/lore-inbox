Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUDPSED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbUDPSED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:04:03 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:17830 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263585AbUDPSD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:03:57 -0400
Message-Id: <200404161803.i3GI3Lce011798@eeyore.valparaiso.cl>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Maneesh Soni <maneesh@in.ibm.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks 
In-Reply-To: Your message of "Fri, 16 Apr 2004 16:24:48 +0100."
             <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Fri, 16 Apr 2004 14:03:21 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk said:
> On Thu, Apr 15, 2004 at 03:02:32PM -0700, Greg KH wrote:
> > No, we don't want that.  It's ok to have a dangling symlink in the fs if
> > the device the link was pointing to is now gone.  All of the struct
> > class_device stuff relies on the fact that a struct device can go away
> > at any time, and nothing bad will happen (with the exception of a stale
> > symlink.)
> > 
> > Yeah, it can cause a few odd looking trees when you unplug and replug a
> > device a bunch of times, all the while grabbing a reference to the class
> > device, but once everything is released by the user, it is cleaned up
> > properly, with no harm done to anything.
> 
> Except that these "symlinks" are expected to follow the target upon
> renames.  Which means that we either need a very messy scanning of
> the entire tree on every rename (obviously not feasible) or we need
> to store pointer to target and regenerate the path.  Which, in turn,
> requires holding a reference.

Sounds an awful lot like ordinary hard links...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
