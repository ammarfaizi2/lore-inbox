Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269720AbUICNwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269720AbUICNwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269696AbUICNtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:49:23 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:29593 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP id S269695AbUICNrg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:47:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16696.30136.391680.920989@gargle.gargle.HOWL>
Date: Fri, 3 Sep 2004 09:46:32 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Lee Revell <rlrevell@joe-job.com>,
       Pavel Machek <pavel@ucw.cz>, Spam <spam@tnonline.net>,
       David Masover <ninja@slaphack.com>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040902232350.GA32244@mail.shareable.org>
References: <rlrevell@joe-job.com>
	<1094155277.11364.92.camel@krustophenia.net>
	<200409022200.i82M0ihC026321@laptop11.inf.utfsm.cl>
	<20040902232350.GA32244@mail.shareable.org>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jamie" == Jamie Lokier <jamie@shareable.org> writes:

Jamie> Horst von Brand wrote:
>> > > You really need archive support in find. At the very least you need
>> > > option "enter archives" vs. "do not enter archives". Entering archives
>> > > automagically is seriously wrong.
>> 
>> I have used find(1) for quite some time now, and have never (or very
>> rarely) missed this.

Jamie> I've occasionally had the need to search all files on my system
Jamie> for the one file which contains a particular phrase -- all I
Jamie> remember is the phrase.

So use glimpse and run an indexer once a night to pick up changes.  

Jamie> Just doing "grep -R" was a tedious job: at least half an hour.

Ugh, esp since you're not caching any results of all that work either,
when you need to repeat 10 minutes down the line...

Jamie> Sometimes, I want to search all source files on my system for a
Jamie> particular word, for example to search for uses of a particular
Jamie> system call or library function.

I think we want to pull this back a bit more and define this better.
Instead of 'system' we should be thinking 'namespace' or 'hierarchy'.  

Jamie> That would require something that could search through all the
Jamie> .tar.gz files and .zip files (nested if necessary) as well as
Jamie> plain files.  It would take so long -- hours at least, maybe
Jamie> more than a day -- that I've never bothered doing such a thing.

Jamie> In other words, I'd use that capability if it was magically
Jamie> fast, but as we expect it to be insanely slow (just grepping
Jamie> gigabytes is slow) that makes it not so useful.

Jamie> However, if we ever see that search engine index thing happen,
Jamie> it would be a most excellent capability if it searched inside
Jamie> archive files too.  I would definitely use that.  Not often,
Jamie> but occasionally I would.

Is the overhead of pre-indexing all files and their contents worth it
though?  And would the use of inotify allow us to efficiently update
the index in a fairly quick time?

All the various arguements have been that we need a filesystem which
magically indexes files, does queries and does it all atomically and
without any thought on the part of the developer/user.  It could
happen, but then we'd have such a *slow* system in general, just to
make 1% of the usage simpler (for some measure of simple) that it
would be a waste.

Providing a simple, consistent set of semantics and syntax allows you
to build on top of it the layer(s) you need to provide the guarenttees
you need for your application.

I don't expect that Oracle has the same needs as does my mail spool,
or as an image store.  Sure, Oracle could do both of them, but are
the overheads of oracle worth the slowdown in the common case?

John
