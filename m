Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUIGQHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUIGQHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268284AbUIGPCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:02:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:49091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268223AbUIGO7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:59:18 -0400
Date: Tue, 7 Sep 2004 07:59:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve French <smfltc@us.ibm.com>
Subject: Re: [PATCH 4/4] copyfile: copyfile
In-Reply-To: <20040907145118.GA29993@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0409070756410.2299@ppc970.osdl.org>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de>
 <20040907121118.GA27297@wohnheim.fh-wedel.de> <20040907121235.GB27297@wohnheim.fh-wedel.de>
 <20040907121520.GC27297@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org>
 <20040907145118.GA29993@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Sep 2004, Jörn Engel wrote:

> On Tue, 7 September 2004 07:06:00 -0700, Linus Torvalds wrote:
> > 
> > Then you could (and should) make a "generic_file_copy()" function that
> > takes that pathname format, and then uses sendfile() to do the copy for
> > regular disk-based filesystems.
> 
> Does that mean that you're ok with the first three patches?

No, it means that they weren't fundamentally flawed..

Actually, the 4kB batching one was - if you only max out to using 4kB at a 
time, sendfile() is kind of pointless, because then it will never do 
multi-page copies in the first place, and all the complexity at a lower 
level is worthless..

		Linus
