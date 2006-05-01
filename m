Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWEALXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWEALXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 07:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWEALXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 07:23:06 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:25809 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932066AbWEALXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 07:23:04 -0400
Date: Mon, 1 May 2006 13:23:03 +0200
From: DervishD <lkml@dervishd.net>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT, ext3fs, kernel 2.4.32... again
Message-ID: <20060501112303.GA1951@DervishD>
Mail-Followup-To: Marcelo Tosatti <marcelo@kvack.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20060427063249.GH761@DervishD> <20060501062058.GA16589@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060501062058.GA16589@dmt>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Marcelo :)

 * Marcelo Tosatti <marcelo@kvack.org> dixit:
> >     Shouldn't ext3fs return an error when the O_DIRECT flag is
> > used in the open call? Is the open call userspace only and thus
> > only libc can return such error? Am I misunderstanding the entire
> > issue and this is a perfectly legal behaviour (allowing the open,
> > failing in the read operation)?
> 
> Your interpretation is correct. It would be nicer for open() to
> fail on fs'es which don't support O_DIRECT, but v2.4 makes such
> check later at read/write unfortunately ;(

    Oops :(
 
> And its too late for changing that IMO...

    Probably. Anyway, since an userspace app shouldn't bother about
which underlying filesystem a file is under, ext3 should:

    - fail in the open() call: OK, it's too late for that.
    - don't check while in read()/write(): I'm not sure about this.

    The problem I see is that I can't tell if (given that probably
the bug cannot be fixed right now) it's better to let the userspace
app believe that O_DIRECT is honored but silently ignore it, or let
the userspace believe that O_DIRECT was honored in the open() call
and make all subsequent calls to read()/write() fail.

    Myself, I would prefer to be deceived and have successful calls
even if the O_DIRECT flag was ignored instead of having successful
calls to open(O_DIRECT) but failures on subsequent read()'s, but I
must confess that I don't know what kind of scenarios need the use of
O_DIRECT and I don't know if having O_DIRECT accepted but ignored is a
good thing :(

    I'm not familiar with the ext3 code, so I don't know if it's easy
to modify it so it will reject an open if O_DIRECT is specified :(((

    Thanks for your answer, Marcelo :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
