Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265994AbUF2TXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUF2TXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUF2TXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:23:43 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:20402 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S265994AbUF2TWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:22:21 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Uploaded Uml patchset for 2.6.7(was: Re: Inclusion of UML in 2.6.8)
Date: Tue, 29 Jun 2004 21:29:52 +0200
User-Agent: KMail/1.5
References: <200406261905.22710.blaisorblade_spam@yahoo.it> <20040626181048.GA16323@infradead.org> <20040627035311.GA8842@ccure.user-mode-linux.org>
In-Reply-To: <20040627035311.GA8842@ccure.user-mode-linux.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406292129.52093.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 05:53, domenica 27 giugno 2004, Jeff Dike ha scritto:
> On Sat, Jun 26, 2004 at 07:10:48PM +0100, Christoph Hellwig wrote:
> > Please send split patches.  E.g. linux/ghash.h should not ne
> > reintroduced, it's completely fuly.

Anyway, I'm going to upload the whole patchset (as it is now); I just tarred 
my ./patch-scripts folder, containing descriptions, .pc files and actual 
patches. The updates from Jeff Dike are not very split, but everything I've 
added is in his own separate patch. Little changes anyway.

I've problems with patch-bomb, so for now here is it:

http://www.user-mode-linux.org/~blaisorblade/patches/bb/uml-patch-2.6.7-01-bb2.tar.bz2

The description of things is below (and in the patches headings, mostly).

Also, my main fear is about 2.7: if it is split before UML is merged, it means 
it won't be updated for all the API changes in 2.7.x.
For who want to flame with "better leave it broken than just doing compile 
fixes": who introduced set_page_count, for instance, grepped and changed it 
everywhere, even in the UML tree. And there was no reason to do so; so it 
would help us having UML in mainline, to react well to such updates.

> That requires a little interface work inside UML, and that was the main
> reason Andrew hasn't seen UML recently.
>
> > Also your above arch_free_page needs some more
> > discussion.
>
> I think that can disappear.  In some cases, it might be handy for the arch
> to see pages being freed, but right now, I believe that UML has no need for
> it.

Hmm, well, indeed that part was added just to support ubd-mmap, which you seem 
to have decided to drop*, but removing it would be hard for me, since it 
would mean doing a lot of checks to physmem handling; and I still don't want 
to fight against all the bugs I'd create. I'm seeing a lot more ones simply 
after switching to Mandrake 10 (don't flame me for this!) for my host.

The same thing holds for COW support: I cannot drop it so simply, since there 
are some references to it in working UBD code. That code should just drop 
them, since IIRC Jeff wants to make COW act on any two block devices; but 
I've not time to do it.

I could, instead, safely remove the /proc/mm support (for running nested UMLs 
in SKAS mode); the patch for this was well tested, so it's included; I'm 
providing a "combinediffed" version of them, since without removing SKAS the 
patch will probably not apply. I've also split ghash.h out.

* But when you say "It's vulnerable to the filesystem making changes to data 
that it intends never to reach the disk" in your diary, you speak about a 
performance problem, right? Or it is even broken?

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

