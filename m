Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUAEPO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUAEPO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:14:59 -0500
Received: from findaloan.ca ([66.11.177.6]:7106 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S261539AbUAEPOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:14:53 -0500
Date: Mon, 5 Jan 2004 10:13:03 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Rob Landley <rob@landley.net>
Cc: David Lang <david.lang@digitalinsight.com>,
       Linus Torvalds <torvalds@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105151303.GA30849@mark.mielke.cc>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	David Lang <david.lang@digitalinsight.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
	Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>
References: <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <Pine.LNX.4.58.0401041903290.6089@dlang.diginsite.com> <200401042148.24742.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401042148.24742.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 09:48:24PM -0600, Rob Landley wrote:
> On Sunday 04 January 2004 21:06, David Lang wrote:
> > Linus, what Andries is saying is that if you export a directory (say
> > /home) the process of exporting it somehow uses the /dev device number so
> > if the server reboots and gets a different device number for the partition
> > that /home is on the clients won't see it as the same export, breaking the
> > NFS requirement that a server can be rebooted.
> NFS always struck me as a peverse design.  "The fileserver must be
> stateless with regard to clients, even though maintainging state is
> what a filesystem DOES, and the point of the thing is to export a
> filesystem."  Okay...  (If it was exporting read-only filesystems
> with no locking of any kind, maybe they'd have a point, but come on
> guys...)

Statelessness translated to capacity back in the day when maintaining state
for hundreds or thousands of machines was expensive...

I don't buy NFS as an excuse, though. I refuse to believe that a
shared /dev is necessary or desirable for *any* environment. /dev/pts
is one example of where everybody seems to have already agreed on
this.

With udev, or with devfs, a shared /dev becomes unnecessary. /dev will
no longer need to be 7000+ entries. It could be a few hundred or less
for common configurations, and 0% persistence/remote storage for
tmpfs-udev or devfs.

There are a few cases that we might be forced to maintain regular
numbers: mkfifo() creates a named pipe, and bind() creates a named
socket. These might be accessed between reboots over NFS, or local
mounts by many existing programs. I think these must be guaranteed to
keep the same major:minor numbers across reboots (preferably, even
across kernel releases). These are exceptional cases, though, and
should be considered as such.

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

