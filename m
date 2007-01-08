Return-Path: <linux-kernel-owner+w=401wt.eu-S1161299AbXAHNnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161299AbXAHNnQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161298AbXAHNnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:43:16 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:54682 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161291AbXAHNnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:43:15 -0500
Message-ID: <45A24A65.1070706@garzik.org>
Date: Mon, 08 Jan 2007 08:43:01 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
       Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       git@vger.kernel.org, nigel@nigel.suspend2.net,
       "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: How git affects kernel.org performance
References: <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org> <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org>
In-Reply-To: <20070108125819.GA32756@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> The fastest and probably most important thing to add is some readahead
> smarts to directories --- both to the htree and non-htree cases.  If
> you're using some kind of b-tree structure, such as XFS does for
> directories, preallocation doesn't help you much.  Delayed allocation
> can save you if your delayed allocator knows how to structure disk
> blocks so that a btree-traversal is efficient, but I'm guessing the
> biggest reason why we are losing is because we don't have sufficient
> readahead.  This also has the advantage that it will help without
> needing to doing a backup/restore to improve layout.


Something I just thought of:  ATA and SCSI hard disks do their own 
read-ahead.  Seeking all over the place to pick up bits of directory 
will hurt even more with the disk reading and throwing away data (albeit 
in its internal elevator and cache).

	Jeff


