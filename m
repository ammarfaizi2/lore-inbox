Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129907AbRBGUOD>; Wed, 7 Feb 2001 15:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130575AbRBGUNy>; Wed, 7 Feb 2001 15:13:54 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:33546 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129907AbRBGUNp>;
	Wed, 7 Feb 2001 15:13:45 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102072013.XAA05418@ms2.inr.ac.ru>
Subject: Re: Bug in tcp_time_to_recover
To: juvvadi@netli.COM
Date: Wed, 7 Feb 2001 23:13:29 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A81A204.3020002@netli.com> from "Ramana Juvvadi" at Feb 7, 1 10:45:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>    /* Not-A-Trick#2 : Classic rule... */
>    if (tcp_fackets_out(tp) > tp->reordering)
>                       ^^^^^^^^^
>        return 1;
...
> Shouldn't it be a >= instead of > ?

No. fackets_out is equivalent of Reno dupacks+1.

F.e. look at the most common case, where FACK is equivalent to Reno:

| hole | sack1 | sack2 | sack3

fackets_out = 4
but
dupacks = 3

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
