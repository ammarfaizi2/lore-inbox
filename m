Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTDUJUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 05:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTDUJUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 05:20:48 -0400
Received: from mail.ithnet.com ([217.64.64.8]:14349 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263791AbTDUJUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 05:20:45 -0400
Date: Mon, 21 Apr 2003 11:32:36 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: John Bradford <john@grabjohn.com>
Cc: john@grabjohn.com, josh@stack.nl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030421113236.3955d5e6.skraw@ithnet.com>
In-Reply-To: <200304201720.h3KHKG9A000716@81-2-122-30.bradfords.org.uk>
References: <20030420190119.048d3a43.skraw@ithnet.com>
	<200304201720.h3KHKG9A000716@81-2-122-30.bradfords.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003 18:20:16 +0100 (BST)
John Bradford <john@grabjohn.com> wrote:

> > > > > Fault tolerance in a filesystem layer means in practical terms
> > > > > that you are guessing what a filesystem should look like, for the
> > > > > disk doesn't answer that question anymore. IMHO you don't want
> > > > > that to be done automagically, for it might go right sometimes,
> > > > > but also might trash everything on RW filesystems.
> > > > 
> > > > Let me clarify again: I don't want fancy stuff inside the filesystem
> > > > that magically knows something about right-or-wrong. The only _very
> > > > small_ enhancement I would like to see is: driver tells fs there is an
> > > > error while writing a certain block => fs tries writing the same
> > > > data onto another block. That's it, no magic, no RAID
> > > > stuff. Very simple. 
> > > 
> > > That doesn't belong in the filesystem.
> > > 
> > > Imagine you have ten blocks free, and you allocate data to all of them
> > > in the filesystem.  The write goes to cache, and succeeds.
> > > 
> > > 30 seconds later, the write cache is flushed, and an error is reported
> > > back from the device.
> > 
> > And where's the problem?
> > Your case:
> > Immediate failure. Disk error.
> > 
> > My case:
> > Immediate failure. Disk error (no space left for replacement)
> > 
> > There's no difference.
> 
> In my case, the machine can continue as normal.  The filesystem is
> intact, (with no blocks free).  The block device driver has to cope
> with the error, which could be as simple as holding the data in RAM
> until an operator has been paged to replace the disk.

Forgive my ignorance, but I have not seen a case up to today where ide, aicX or
3ware has called me up for a replacement unit, written to it and been ok
afterwards. What the heck are you talking of?
I am not really interested in what a low-level driver could do unless there is
none that does it...
And again, how do you think this should work out on your _root_ partition? (see
below)

> In your case, the filesystem is no longer in a usable state.

I have yet to see an fs thats in a writeable state after the medium is full ...

>  If that
> was the root filesystem, the machine will, at best, probably go in to
> single user mode, with a read-only root filesystem.

How come?

> > Thing is: If there are 11 blocks free and not ten, then you fail
> 
> Wrong.  See above.

Please tell me when you were last "paged to replace the disk"? If you can't
tell me, then you know I am right by now.

> > and I succeed (if there's one bad block). You loose data, I don't.
> 
> John.

Regards,
Stephan

