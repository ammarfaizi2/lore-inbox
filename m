Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbUAEDmp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265868AbUAEDmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:42:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46491 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265335AbUAEDmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:42:43 -0500
Date: Mon, 5 Jan 2004 03:42:42 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105034242.GC4176@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <20040104223710.GY4176@parcelfarce.linux.theplanet.co.uk> <20040105032901.A11459@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105032901.A11459@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 03:29:01AM +0100, Andries Brouwer wrote:
> On Sun, Jan 04, 2004 at 10:37:10PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Hi Al - a happy 2004 to you too!
> 
> > Now, care to explain how preserving aforementioned common Unix idiom
> > is related to your expostulations?
> 
> Hmm. You sound like you agree that random device numbers and NFS
> are a bad combination, but don't see why my example might be
> relevant.

No.  I don't see what the fuck does it have to POSIX compliance, ability
to determine whether two files are identical by st_ino/st_dev and common
UNIX idioms.
 
> There is a great variation here in what various servers and clients do,
> but roughly speaking filehandles tend to contain a fsid, and this fsid
> often (no fsid= given) involves (major,minor,ino).

Now, _that_ is true.  And yes, I agree that setups with unstable device
numbers do need explicit actions on part of admin.  In particular, editing
/etc/exports to add fsid= in each relevant entry.

Which means that *in* *setups* *where* *numbers* *are* *currently* *stable*
we should not make them random without admin's knowledge.  And /etc/exports
is not the only problem - RAID, journaling filesystems with device number of
log stored on-disk, etc.

*However*, if we are talking about new classes of devices, all bets are off
and proper fix is to stop using unsuitable interfaces for those devices.
For exports it means "use explicit fsid".  For RAID we both agreed, IIRC,
that raidtools will need to switch to saner API, etc.
