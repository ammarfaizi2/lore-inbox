Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUGJAoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUGJAoJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 20:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUGJAoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 20:44:09 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:64642 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265985AbUGJAoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 20:44:01 -0400
Message-ID: <40EF3BCD.7080808@comcast.net>
Date: Fri, 09 Jul 2004 20:43:57 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       linux-c-programming <linux-c-programming@vger.kernel.org>
Subject: Garbage Collection and Swap
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've been researching garbage collection.

Let me first get it out in the open that I *despise* the concept of
garbage collection.  I worried when I first heard of a magical automatic
free()/delete[] that it would do one or more of two things:

~ - Create excessive overhead
~ - Free up ram I'm still using

I've learned that the first may or may not be true.  This means that
they've won on some accounts with that one.

The second may or may not occur as well.  It worries me that it may in
certain cases, due to the way GC works.  Most garbage collectors will
look in the heap, maybe the stack, maybe other places, for what looks
like pointers to allocated ram.  If they don't find any, they free the ram.

So, the first extremely obvious thing you'll notice is that GC may at
times miss things, especially if you use the XOR linked list trick or
use your own makeshift swap file (write pointers to disk, read back in).

After a while, a big one hit me.

THE GARBAGE COLLECTOR WANDERS AROUND IN THE ENTIRE HEAP, AND IN SOME
CASES IN OTHER PARTS OF RAM, LOOKING FOR WHAT LOOKS LIKE POINTERS TO
YOUR ALLOCATED DATA.

Read that.  It's in all caps, so you should read it.  It has meaning.

How about, everything is using Bohem GC.  Bohem wanders around in the
heap concurrently.  So all of your applications are wandering around
through their vm space everywhere, continuously.

You get low on ram.  Let's say an app is using 500M of ram (Mozilla).
What's going to happen?  Obvious.  It's going to yank shit out of swap.

If we all linked against a GC, what kinds of swap hell do you think we'd
encounter?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7zvMhDd4aOud5P8RAh8zAJ9zTAH2D+aJOpK60Gz2FiWfKE/iYQCfShG1
GuXdbh0ZRJuwCX2fLleOBbw=
=Glt1
-----END PGP SIGNATURE-----
