Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274683AbRJEX6M>; Fri, 5 Oct 2001 19:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274681AbRJEX6C>; Fri, 5 Oct 2001 19:58:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18188 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274653AbRJEX5v>; Fri, 5 Oct 2001 19:57:51 -0400
Subject: Re: Desperately missing a working "pselect()" or similar...
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Sat, 6 Oct 2001 01:03:04 +0100 (BST)
Cc: alex@pennace.org (Alex Pennace), ecki@lina.inka.de (Bernd Eckenfels),
        linux-kernel@vger.kernel.org
In-Reply-To: <15294.16536.430907.650513@notabene.cse.unsw.edu.au> from "Neil Brown" at Oct 06, 2001 09:22:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pevo-00088G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A technique I used in a similar situation once went something like:
> 
> tv.tv_sec=bignum;
> tv.tv_usec = 0;
> enable_signals();
> select(nfds, &readfds,&writefds,0,&tv);
> 
> and have the signal handlers set tv.tv_sec to 0. (tv is a global
> variable).
> 
> Then if the signal comes before the select, the select exits
> immediately.

You can do this more cleanly with sigsetjmp - it avoids any risk of suprises
in the library itself - eg the select to poll mapper in some libraries - and
indeed even the variable load into registers for a syscall
 
