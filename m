Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSEVSQP>; Wed, 22 May 2002 14:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316633AbSEVSQN>; Wed, 22 May 2002 14:16:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43525 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316632AbSEVSQL>; Wed, 22 May 2002 14:16:11 -0400
Subject: Re: Have the 2.4 kernel memory management problems on large machines
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 22 May 2002 19:34:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        wli@holomorphy.com (William Lee Irwin III),
        Martin.Bligh@us.ibm.com (Martin J. Bligh),
        znmeb@aracnet.com (M. Edward Borasky), linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, akpm@zip.com.au
In-Reply-To: <Pine.LNX.4.33.0205221048570.23621-100000@penguin.transmeta.com> from "Linus Torvalds" at May 22, 2002 11:08:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Aawp-0002Vt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You don't strictly even need to LRU it - you could just keep a pte count 
> aroudn, and when it goes to zero you zap the pmd. You can use the normal 
> page_count() thing for it.

That assumes you want to page out the page table only after the pages it
references are paged out. There is no reason I can see for not flushing it
first. Its very cheap to regenerate for non-anonymous pages - much cheaper
than the pages it references. Also the locality of most apps means that
there are zillions of glibc pages they reference only once (for init, and
for linker fixups/names)

