Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUAEDtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUAEDtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:49:10 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:14035
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265871AbUAEDtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:49:06 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: David Lang <david.lang@digitalinsight.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: udev and devfs - The final word
Date: Sun, 4 Jan 2004 21:48:24 -0600
User-Agent: KMail/1.5.4
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
References: <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <Pine.LNX.4.58.0401041903290.6089@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.58.0401041903290.6089@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401042148.24742.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 January 2004 21:06, David Lang wrote:
> Linus, what Andries is saying is that if you export a directory (say
> /home) the process of exporting it somehow uses the /dev device number so
> if the server reboots and gets a different device number for the partition
> that /home is on the clients won't see it as the same export, breaking the
> NFS requirement that a server can be rebooted.

NFS always struck me as a peverse design.  "The fileserver must be stateless 
with regard to clients, even though maintainging state is what a filesystem 
DOES, and the point of the thing is to export a filesystem."  Okay...  (If it 
was exporting read-only filesystems with no locking of any kind, maybe they'd 
have a point, but come on guys...)

So here's an example of where the fileserver _does_ expect to maintain 
non-file state across reboots.  "Ooh, the device node we're exporting is part 
of the ID, gee, we missed one!"

So why, exactly, can the NFS server not maintain whatever extra state it needs 
to remember between reboots in a filesystem?  (Not even necessarily the one 
it's exporting, just some rc file something under /var.)  The device node it 
was exporting USED to be in the filesystem, you know, ala mknod.  Now that 
the kernel's not keeping that stable, have the #*%(&# server generate a 
number and make a note of it somewhere.  (Is requiring an NFS server to have 
access to persistent storage too much to ask?)

Personally, I could never figure out why Samba servers are in userspace but 
NFS servers seem to want to live in the kernel.  I can almost secure a samba 
server for access to the outside world, but a NFS system that isn't behind a 
firewall automatically says to me "this machine has already been compromised 
eight ways from sunday within five minutes of being exposed to the internet".  
Call me paranoid...

Rob

