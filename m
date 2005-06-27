Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVF0XEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVF0XEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVF0XDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:03:03 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:2274 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262092AbVF0XAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:00:00 -0400
Message-ID: <42C084F1.70607@namesys.com>
Date: Mon, 27 Jun 2005 16:00:01 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Markus T?rnqvist <mjt@nysv.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>, Steve Lord <lord@xfs.org>
Subject: Re: reiser4 merging action list
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com> <20050627212628.GB27805@thunk.org>
In-Reply-To: <20050627212628.GB27805@thunk.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew asked me to put together a list of things that need to be done
before merging:

    * VFS will dispatch directly to the method of the plugin for the
*_operations methods.  This requires duplicating to all plugin methods
the common code currently used by all reiser4 plugins for a given
method.  It has the desirable side effect of making the methods more
fully self-contained, which is somethng I had wanted two years ago and
was a little sad to not get, and the cost of duplicating some code. 
Since not all plugin methods are *_operations, it means we have two
structures with duplicated data, and duplicate data that must be in sync
at all times is classical badness in programming technique (see Codd and
normalization).                                 vs owns this task

    * review all sparse complaints, and revise as appropriate. 

    * panic and code beauty: everyone agrees that having function, file,
and line added to reiser4_panic output hurts nothing (I hope).  Everyone
agrees that restarting the machine without an error message seems like a
useless option to allow.   Much else was argued, not sure if anything
was a consensus view.  Various detail improvements were suggested by
Pecca, and I agreed with half of them.


   * metafiles should be disabled until we can present code that works
right.  Half the list thinks we cannot solve the cycles problem ever. 
Disable metafiles and postpone problem until working code, or the
failure to produce it, makes it possible to do more than rant at each
other.  This is currently already done in the -mm patches, but is
mentioned lest someone think it forgotten.

   * update the locking documentation

Probably I forget something.

Best,

Hans
