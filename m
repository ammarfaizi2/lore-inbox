Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268331AbUIBO1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268331AbUIBO1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268334AbUIBO1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:27:25 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:735 "EHLO
	ihemail2.lucent.com") by vger.kernel.org with ESMTP id S268331AbUIBO1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:27:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16695.11572.597617.419870@gargle.gargle.HOWL>
Date: Thu, 2 Sep 2004 10:24:52 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <4136E0B6.4000705@namesys.com>
References: <20040826150202.GE5733@mail.shareable.org>
	<200408282314.i7SNErYv003270@localhost.localdomain>
	<20040901200806.GC31934@mail.shareable.org>
	<Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	<20040902002431.GN31934@mail.shareable.org>
	<413694E6.7010606@slaphack.com>
	<Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
	<4136A14E.9010303@slaphack.com>
	<Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
	<4136C876.5010806@namesys.com>
	<Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
	<4136E0B6.4000705@namesys.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hans> For 30 years nothing much has happened in Unix filesystem
Hans> semantics because of sheer cowardice (excepting Clearcase, which
Hans> priced itself into a niche market).

Keeping a consistent namespace is cowardice?  And ClearCase is an
example of an application which sets up it's own namespace and grafts
it onto the standard Unix one.  Most standard Unix tools work just
fine inside clearcase Views, but to manage the metadata (xattrs, or
whatever you want to call them), you need to use the 'cleartool'
command.  Hmmm... sounds like 'runat' to me.

Hans> It is 25 years past time for someone to change things.  That
Hans> someone will have first mover advantage, and the more little
Hans> semantic features possessed the more lure there will be to use
Hans> it which will increase market share which will lure more apps
Hans> into depending on it and in a few years the other filesystems
Hans> will (deservedly) have only a small market share because the
Hans> apps won't all work on them.

This is all pure marketing speak and economic theory.  Show us the
*technical* advantages, not just wishful thinking.  

Hans> Besides, there are enhancements which are simply compelling.
Hans> You can write a dramatically better performance version control
Hans> system with a much simpler design if the FS is atomic. 

Define atomic please, with state diagrams and clear examples.  

Hans> We have the performance lead.  By next year we will be stable
Hans> enough for mission critical servers, and then we start the
Hans> serious semantic enhancements.

I think you've got it backwards.  Make your serious semantic
enhancements first, then make it stable, then make it fast.  Because
when you change the semantics, you break all kinds of things and then
it doesn't matter how fast you are.

Hans> If you don't embrace progress, then you doom Linux to following
Hans> behind, because the guys at Apple are pretty aggressive now that
Hans> Jobs is back, and they WILL change the semantics, and they will
Hans> do so in compelling ways, and Linux will be reduced to aping
Hans> them when it should be leading them.

Monkey see, Monkey do then.  


I'd like to point out another successful company which has extended
the standard Unix namespace and that's 'Network Appliance' with it's
.snapshot directory structure.  It's a great idea and allows my users
to restore files from snapshots without me having to think about it.  

But it still causes problems since when I use rsync to move data, I
need to put in stuff like:

  rsync -az --exclude ".snapshot" --delete --delete-excluded <src> <dest>

to make sure it doesn't descend into that directory of previous
versions and try to copy them over as well.  And of course now now
other apps can use the .snapshot name.  But what if other vendors aped
(ook ook) this decided to use their own names?  Who decides which gets
priority?  

I think you need to go back and re-read Pike's paper on namespaces
that you pointed to before and mull it over.  And look at how
simplicity is inherently powerful.  If the design is too complicated,
you're probably doing it wrong.

John
