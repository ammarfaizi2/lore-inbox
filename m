Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268209AbUIGPcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268209AbUIGPcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268312AbUIGP3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:29:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:52953 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268073AbUIGP2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:28:09 -0400
Date: Tue, 7 Sep 2004 08:28:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve French <smfltc@us.ibm.com>
Subject: Re: [PATCH 4/4] copyfile: copyfile
In-Reply-To: <20040907152118.GA30396@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0409070826550.2299@ppc970.osdl.org>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de>
 <20040907121118.GA27297@wohnheim.fh-wedel.de> <20040907121235.GB27297@wohnheim.fh-wedel.de>
 <20040907121520.GC27297@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org>
 <20040907145118.GA29993@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409070756410.2299@ppc970.osdl.org>
 <20040907152118.GA30396@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Sep 2004, Jörn Engel wrote:
> 
> > Actually, the 4kB batching one was - if you only max out to using 4kB at a 
> > time, sendfile() is kind of pointless, because then it will never do 
> > multi-page copies in the first place, and all the complexity at a lower 
> > level is worthless..
> 
> Give me a better number.  16k?  1M?  Or would it not be fundamentally
> flawed if the unit was seconds, instead of bytes?  That makes a lot
> more sense, since a floppy and a Ultra320 RAID array differ slightly
> in speed and it's response time the users actually care about.

Well, you can't do it by seconds. What you _can_ do is to just make the 
fundamental page-cache sendfile thing check for interruptible, and just do 
it at a lower level. Maybe.

		Linus
