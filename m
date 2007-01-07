Return-Path: <linux-kernel-owner+w=401wt.eu-S932499AbXAGLFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbXAGLFY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 06:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbXAGLFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 06:05:23 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:36246 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932499AbXAGLFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 06:05:20 -0500
Date: Sun, 7 Jan 2007 11:50:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Willy Tarreau <w@1wt.eu>
cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@osdl.org>,
       git@vger.kernel.org, nigel@nigel.suspend2.net,
       "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
In-Reply-To: <20070107090336.GA7741@1wt.eu>
Message-ID: <Pine.LNX.4.61.0701071141580.4365@yvahk01.tjqt.qr>
References: <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain>
 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
 <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com>
 <20070107090336.GA7741@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 7 2007 10:03, Willy Tarreau wrote:
>On Sun, Jan 07, 2007 at 12:58:38AM -0800, H. Peter Anvin wrote:
>> >[..]
>> >entries in directories with millions of files on disk. I'm not
>> >certain it would be that easy to try other filesystems on
>> >kernel.org though :-/
>> 
>> Changing filesystems would mean about a week of downtime for a server. 
>> It's painful, but it's doable; however, if we get a traffic spike during 
>> that time it'll hurt like hell.

Then make sure noone releases a kernel ;-)

>> However, if there is credible reasons to believe XFS will help, I'd be 
>> inclined to try it out.
>
>Hmmm I'm thinking about something very dirty : would it be possible
>to reduce the current FS size to get more space to create another
>FS ? Supposing you create a XX GB/TB XFS after the current ext3,
>you would be able to mount it in some directories with --bind and
>slowly switch some parts to it. The problem with this approach is
>that it will never be 100% converted, but as an experiment it might
>be worth it, no ?

Much better: rsync from /oldfs to /newfs, stop all ftp uploads, rsync
again to catch any new files that have been added until the ftp
upload was closed, then do _one_ (technically two) mountpoint moves
(as opposed to Willy's idea of "some directories") in a mere second
along the lines of

  mount --move /oldfs /older; mount --move /newfs /oldfs.

let old transfers that still use files in /older complete (lsof or
fuser -m), then disconnect the old volume. In case /newfs (now
/oldfs) is a volume you borrowed from someone and need to return it,
well, I guess you need to rsync back somehow.


	-`J'
-- 
