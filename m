Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbTAVHXk>; Wed, 22 Jan 2003 02:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTAVHXk>; Wed, 22 Jan 2003 02:23:40 -0500
Received: from angband.namesys.com ([212.16.7.85]:51072 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267368AbTAVHXk>; Wed, 22 Jan 2003 02:23:40 -0500
Date: Wed, 22 Jan 2003 10:32:43 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] vmtruncate releases pages of MAP_PRIVATE vma
Message-ID: <20030122103243.A1750@namesys.com>
References: <m3hec2i9su.fsf@lexa.home.net> <3E2DA4A5.C5C17138@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3E2DA4A5.C5C17138@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Jan 21, 2003 at 11:51:01AM -0800, Andrew Morton wrote:

> > I think vmtruncate() should preserve that pages.
> That would make sense.  But we'd have to go and create zillions
> of copies of pages inside truncate, and given that the behaviour
> is unspecified, it is questionable whether anyone should be
> relying on the behaviour anyway..

It is way too easy to truncate some library and all executables (that are loaded
right now) will go nuts (Just did echo >/lib/libncurses.so.5.2 and expected
everything will get SIGBUS, but all the bashes and mutt went crazy consuming
memory until oom-killer killed them. Kind of surprising behaviour, I'd say.
Test was done on 2.4.19).
Also *BSD systems seems to return -ETXTBSY not only when you try to write-open 
running executables, but also all of shared libs used (and this is probably
even more logical ).

Bye,
    Oleg
