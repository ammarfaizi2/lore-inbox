Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSKXOnx>; Sun, 24 Nov 2002 09:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSKXOnw>; Sun, 24 Nov 2002 09:43:52 -0500
Received: from host194.steeleye.com ([66.206.164.34]:1036 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261356AbSKXOnt>; Sun, 24 Nov 2002 09:43:49 -0500
Message-Id: <200211241450.gAOEosO10740@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Ed Tomlinson <tomlins@cam.org>
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: Invalid module format - how does one fix this?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Nov 2002 08:50:54 -0600
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.5.49-mm1 works ok here (shpte enabled too).  I see two frustrating
> problems left with the modules change (user perspective).  The most
> irratating one is messages like:

> FATAL: Error inserting /lib/modules/2.5.49-mm1/kernel/ac97_codec.o:
> Invalid module format

> I get this on about 10% of the modules I want to load.  How do I fix
> it?

It seems that the new module loader *requires* init routines (they were 
optional on the old one) so a lot of modules that are simply helper routines 
and didn't previously have an init now need one.

I fixed this on my 53c700.c library module by adding

no_module_init;

at the end of the file.

> The second is that automatic loading is not working.  Manually loading
> modules is a PITA. What plans are there to fix this?

This hasn't annoyed me enough that I've looked into it yet.  I suspec the new 
modprobe doesn't know about the in-kernel module names (or to look in 
/etc/modules.conf) yet.

James



