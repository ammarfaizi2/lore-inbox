Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVLDEqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVLDEqg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 23:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVLDEqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 23:46:35 -0500
Received: from user-0c938qu.cable.mindspring.com ([24.145.163.94]:8138 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1750715AbVLDEqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 23:46:35 -0500
From: Luke-Jr <luke-jr@utopios.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Sun, 4 Dec 2005 04:46:31 +0000
User-Agent: KMail/1.9
References: <20051203152339.GK31395@stusta.de> <20051203225020.GF25722@merlin.emma.line.org> <20051204002043.GA1879@kroah.com>
In-Reply-To: <20051204002043.GA1879@kroah.com>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512040446.32450.luke-jr@utopios.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 December 2005 00:20, Greg KH wrote:
> > Switch "broken bloaty bulky devfs" to "lean & clean devfs"?  This ship
> > would have been flying the "clean-up nation" flags.
>
> Again, because an in-kernel devfs is not the correct thing to do.  devfs
> has been disabled for a few months now, and I don't think anyone has
> missed it yet :)

Well, devfs does have some abilities udev doesn't: hotplug/udev doesn't detect 
everything, and can result in rarer or non-PnP devices not being 
automatically available; devfs has the effect of trying to load a module when 
a program looks for the devices it provides-- while it can cause problems, it 
does have a possibility to work better. Interesting effects of switching my 
desktop from devfs to udev:
1. my DVD burners are left uninitialized until I manually modprobe ide-cd or 
(more recently) ide-scsi
2. my sound card is autodetected and the drivers loaded, but the OSS emulation 
modules are omitted; with devfs, they would be autoloaded when an app tried 
to use OSS
devfs also has the advantage of keeping the module info all in one place-- the 
kernel or the module. In particular, with udev the detection and /dev info is 
scattered into different locations of the filesystem. This can probably be 
fixed easily simply by having udev read such info from modules or via a /sys 
entry, though.
-- 
Luke-Jr
Developer, Utopios
http://utopios.org/
