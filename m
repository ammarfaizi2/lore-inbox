Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbTDTQtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTDTQtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:49:33 -0400
Received: from mail.ithnet.com ([217.64.64.8]:21777 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263629AbTDTQtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:49:32 -0400
Date: Sun, 20 Apr 2003 19:01:19 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: John Bradford <john@grabjohn.com>
Cc: josh@stack.nl, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030420190119.048d3a43.skraw@ithnet.com>
In-Reply-To: <200304201640.h3KGeTs6000657@81-2-122-30.bradfords.org.uk>
References: <20030420180720.099b4c34.skraw@ithnet.com>
	<200304201640.h3KGeTs6000657@81-2-122-30.bradfords.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003 17:40:29 +0100 (BST)
John Bradford <john@grabjohn.com> wrote:

> > > Fault tolerance in a filesystem layer means in practical terms
> > > that you are guessing what a filesystem should look like, for the
> > > disk doesn't answer that question anymore. IMHO you don't want
> > > that to be done automagically, for it might go right sometimes,
> > > but also might trash everything on RW filesystems.
> > 
> > Let me clarify again: I don't want fancy stuff inside the filesystem that
> > magically knows something about right-or-wrong. The only _very small_
> > enhancement I would like to see is: driver tells fs there is an error while
> > writing a certain block => fs tries writing the same data onto another
> > block. That's it, no magic, no RAID stuff. Very simple.
> 
> That doesn't belong in the filesystem.
> 
> Imagine you have ten blocks free, and you allocate data to all of them
> in the filesystem.  The write goes to cache, and succeeds.
> 
> 30 seconds later, the write cache is flushed, and an error is reported
> back from the device.

And where's the problem?
Your case:
Immediate failure. Disk error.

My case:
Immediate failure. Disk error (no space left for replacement)

There's no difference.


Thing is: If there are 11 blocks free and not ten, then you fail and I succeed
(if there's one bad block). You loose data, I don't.


Regards,
Stephan
