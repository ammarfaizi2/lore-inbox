Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTDUKOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 06:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbTDUKOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 06:14:15 -0400
Received: from mail.ithnet.com ([217.64.64.8]:39695 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263807AbTDUKOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 06:14:12 -0400
Date: Mon, 21 Apr 2003 12:25:44 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: John Bradford <john@grabjohn.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, adilger@clusterfs.com,
       john@grabjohn.com, linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030421122544.5ae6bd6f.skraw@ithnet.com>
In-Reply-To: <200304210942.h3L9gZ1W000282@81-2-122-30.bradfords.org.uk>
References: <200304210917.h3L9HIu07472@Port.imtp.ilyichevsk.odessa.ua>
	<200304210942.h3L9gZ1W000282@81-2-122-30.bradfords.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003 10:42:35 +0100 (BST)
John Bradford <john@grabjohn.com> wrote:

> > > > > > > I wonder whether it would be a good idea to give the linux-fs
> > > > > > > (namely my preferred reiser and ext2 :-) some
> > > > > > > fault-tolerance.
> > >
> > > I'm not against this in principle, but in practise it is almost
> > > useless. Modern disk drives do bad sector remapping at write time, so
> > > unless something is terribly wrong you will never see a write error
> > > (which is exactly the time that the filesystem could do such
> > > remapping).  Normally, you will only see an error like this at read
> > > time, at which point it is too late to fix.
> > 
> > It is *not* useless.
> > 
> > I have at least 4 disks with some bad sectors. Know what?
> > They are still in use in a school lab and as 'big diskettes'
> > (transferring movies etc). I refuse to dump them just because
> > 'todays disks are cheap'. I don't want my fs to die just because
> > these disks develop (ohhhh) a single new bad sector.
> 
> Read my previous posts.
> 
> A layer between device and filesystem can solve this.  It doesn't
> belong in the filesystem.

Yes it _can_, but is it _intelligent_ to do it there?


Ok, lets do it vice versa:

What do you need to do it?
- a free/allocated block list (for knowing where to put the mapped block)
- a bad block list for monitoring purposes
- spare blocks for really putting the data in

You say:
we re-invent/re-install the above information in a new layer. In this case you
have the problem to find known-to-be-free blocks. In other words, you have to
pre-alloc blocks (a fixed number) on the device, because else you interfer with
fs. fs must not see your mapped-blocks-in-spe, or else will use them sooner or
later. In other words you _waste_ them in case they are never needed.

I say:
we already have the needed information inside every fs, why not use it?
No space wasted, no double information.

If you say "it does not belong to fs" then please tell me: where in what bible
do you read that? Your argument sounds like "god-given" to me. Do you see
simple argueable technical issues?

I do not say it is _easy_ to do, I say it is an intelligent option. Note the
difference.

Regards,
Stephan

