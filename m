Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278642AbRJSUFK>; Fri, 19 Oct 2001 16:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278643AbRJSUFB>; Fri, 19 Oct 2001 16:05:01 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:44710 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278642AbRJSUEm>; Fri, 19 Oct 2001 16:04:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Fri, 19 Oct 2001 22:07:39 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0110191108590.17647-100000@osdlab.pdx.osdl.net> <15uerh-0NbBEeC@fmrl04.sul.t-online.com> <20011019122101.G2467@mikef-linux.matchmail.com>
In-Reply-To: <20011019122101.G2467@mikef-linux.matchmail.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15uft5-12MXk8C@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 October 2001 21:21, you wrote:
> > For example for harddisks. You usually want them to be mounted in the
> > same directory.
> When is /etc/fstab going to support this?

You can use the device ids to provide stable symlinks, then /etc/fstab 
shouldn't be a problem. Or you rewrite mount to support it. Or you do it in 
the kernel with a user-space helper: when a new device is connected its ID is 
sent to some user-space app, and the user-space app then assigns a minor 
number and devfs name to the node.

IMHO using the path of a file in /dev to identify a device node does not work 
in a hotplugging environment. You need this to support existing apps, but the 
only way to be sure that you always get the same device is to use device IDs. 
You could encode that device id in the node's path or use the path as a 
moniker for the device id (the symlink solution does this), but you need to 
have more information about the device than it's minor number (the X in 
/dev/lpX).


> >Or for ethernet adapters:
> > because each is connected to a different network, so you need to assign
> > different IP addresses to them.
> I haven't seen anything assign ethX assign a certain order, except for
> ordered module loading, and then if there are multiple devices with the
> same driver, the order is chosen by bus scanning order, or module option.

Ok, but I think no one doubts that it is a bad idea to assign ethX 
semi-randomly. Basically this is the same problem as with device files, only 
in a different namespace.


> Does anyone know if devfs will, or has any plans to support any of the
> above features?

The device registry (www.tjansen.de/devreg) patches devfs to allow the things 
described above though.

bye...

