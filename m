Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbSIXSrK>; Tue, 24 Sep 2002 14:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261760AbSIXSrK>; Tue, 24 Sep 2002 14:47:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32005 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261759AbSIXSrJ>; Tue, 24 Sep 2002 14:47:09 -0400
Date: Tue, 24 Sep 2002 11:55:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Patrick Mochel <mochel@osdl.org>
cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
In-Reply-To: <Pine.LNX.4.44.0209241118130.966-200000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0209241146520.7652-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Sep 2002, Patrick Mochel wrote:
> 
> Also, the owner of the device is root, and I easily make the permissions 
> more stringent (i.e. make it S_IRUGO only always).

Well, that would _have_ to be the case, right now you give read access to 
every single device exported this way. Not acceptable.

I really suspect that it would be better to not export the device itself,
but export just device data. In particular, that avoids the security
issues altogether, and it's most likely what a hotplug agent really wants
anyway (and the pure node is useless without a hotplug agent, as the
default kernel permissions would have to be so anal as to make it not
interesting).

So I'd suggest you just export a text-file that describes the thing. 
Something like

 - legacy name (the kernel knows about these anyway, see /proc/mounts and 
   friends)
 - major number, minor number) and char vs block

that way a simple script can just basically do the equivalent of "MAKEDEV" 
at hotplug time using the legacy name as a key to whatever permission and 
ownership heuristics it has (the way MAKEDEV already does)

		Linus

