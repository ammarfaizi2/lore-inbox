Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSIHVse>; Sun, 8 Sep 2002 17:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSIHVsd>; Sun, 8 Sep 2002 17:48:33 -0400
Received: from adsl-67-36-120-9.dsl.klmzmi.ameritech.net ([67.36.120.9]:38786
	"EHLO tabriel.tabris.net") by vger.kernel.org with ESMTP
	id <S315406AbSIHVsc> convert rfc822-to-8bit; Sun, 8 Sep 2002 17:48:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tabris <tabris@tabris.net>
To: Lawrence Walton <lawrence@the-penguin.otak.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: opps 2.4.20-pre5-ac2
Date: Sun, 8 Sep 2002 17:53:14 -0400
User-Agent: KMail/1.4.3
References: <20020908203126.GA11475@the-penguin.otak.com>
In-Reply-To: <20020908203126.GA11475@the-penguin.otak.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209081753.14660.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an interaction of the rmap vm patch (included in -ac) and the nVidia 
binary driver. I have run into this myself, tho it doesn't usually cause a 
lockup for me. (instead, it puts kswapd in the Z state (it aparrently never 
respawns), and makes shutting down a PITA.))

Mind you, this is a bug in the nVidia driver, not the linux kernel, where it 
pulls a behaviour that never was really correct before, but did work. This 
bug truly needs to be reported to nVidia.

Not having that specific kernel tree on my system atm, I can't seem to find 
the line that is BUG()'ing. But iirc, it's in this set


        if (page->buffers)
                BUG();
        if (page->mapping)
                BUG();
        if (!VALID_PAGE(page))
                BUG();
        if (PageLocked(page))
                BUG();
        if (PageActive(page))
                BUG();
        page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));


and is the (page->mapping) test.

please, check your tree for the correct line (102 of page_alloc.c) to verify 
this, and then pass it along to nVidia.

--
tabris
