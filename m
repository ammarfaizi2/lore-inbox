Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269153AbUICPgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269153AbUICPgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269032AbUICPdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:33:37 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:56901 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269422AbUICPRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:17:36 -0400
Message-ID: <9e4733910409030817311e58ef@mail.gmail.com>
Date: Fri, 3 Sep 2004 11:17:30 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Cc: Jamie Lokier <jamie@shareable.org>,
       Christer Weinigel <christer@weinigel.se>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <1094164023.6163.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040901200806.GC31934@mail.shareable.org>
	 <200409021407.i82E70hx004899@laptop11.inf.utfsm.cl>
	 <20040902173214.GB24932@mail.shareable.org>
	 <m3pt54il82.fsf@zoo.weinigel.se>
	 <20040902214731.GF24932@mail.shareable.org>
	 <1094164023.6163.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Sep 2004 23:27:06 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2004-09-02 at 22:47, Jamie Lokier wrote:
> >     - Can the daemon keep track of _every_ file on my disk like this?
> >       That's more than a million files, and about 10^5 directories.
> >       dnotify would require the daemon to open all the directories.
> >       I'm not sure what inotify offers.
> 
> This is currently a real issue for both desktop search and for virus
> scanners. They want a "what changed and where" system wide (or at least
> per namespace/mount).

In the database work everything is a transaction and the transactions
are logged. Reiser4 is fully atomic and logged. So to get the "what
changed and where" you just process the transaction logs from the
point of your last marked checkpoint. Hot backup db servers work this
way too by listening to the transaction log stream. You don't need a
daemon in this model.

Jon Smirl
jonsmirl@gmail.com
