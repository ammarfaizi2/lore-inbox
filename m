Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbUAEDI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265867AbUAEDI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:08:29 -0500
Received: from nevyn.them.org ([66.93.172.17]:62167 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265863AbUAEDIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:08:23 -0500
Date: Sun, 4 Jan 2004 22:07:37 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105030737.GA29964@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
	rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 06:52:56PM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 4 Jan 2004, Andries Brouwer wrote:
> > 
> > Surprise! Are you leaving POSIX? Or ditching NFS?
> > Or demanding that NFS servers must never reboot?
> 
> Ok, Andries, time for you to take a deep breath, and calm down. Because 
> your arguments are getting ridiculous in the extreme.
> 
> A NFS server is sure as hell not going to export _its_ dynamic /dev to its 
> clients. That would be not just stupid, but crazy. Next you tell me that 
> you were using devfs and exporting that over NFS. 
> 
> A NFS server is going to export something _totally_ different than its own 
> /dev directory - it needs to be _client_-specific anyway. That's true with 
> stable numbers too, btw - ever tried to mount a Solaris /dev on a Linux 
> client? No workee.

I think you two are talking straight past each other.  Andries is
talking about the fsid, which is determined by the NFS server, based on
its idea of the device number of the filesystem underlying the exported
directory.  Right now, I can reboot my host system, and when it comes
up then the NFS directories it exports to clients will have the same
fsid.  With random device numbers it won't work; after rebooting the
NFS server all clients will be forced to explicitly unmount and
remount.

Now, it seems to me that this isn't much of an argument against random
device numbers.  Have userspace set a UUID for the device if you want,
and use that in the fsid instead.  But that's the argument; it has
nothing to do with the NFS server exporting its /dev.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
