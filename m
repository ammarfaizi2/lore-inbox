Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286354AbRLJSfi>; Mon, 10 Dec 2001 13:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286353AbRLJSf2>; Mon, 10 Dec 2001 13:35:28 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:8199 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S286358AbRLJSfU>;
	Mon, 10 Dec 2001 13:35:20 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200112101834.VAA17862@ms2.inr.ac.ru>
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2
To: Mika.Liljeberg@welho.com (Mika Liljeberg)
Date: Mon, 10 Dec 2001 21:34:47 +0300 (MSK)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C14FBE7.E3A5F745@welho.com> from "Mika Liljeberg" at Dec 10, 1 08:16:07 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Either LAST-ACK is completely broken or Linux just cannot handle a
> FIN-ACK that is piggybacked on a data segment, when received in LAST-ACK
> state. 

It cannot handle even pure FIN in this state. :-( I bring apologies,
it is my fault. Thank you.

Well, you can just add one line to tcp_input.c to repair this.

                }
                /* Fall through */
+       case TCP_LAST_ACK:
        case TCP_ESTABLISHED:
                tcp_data_queue(sk, skb);


Dave, "official" patch will follow later. I must think about
some marginal effect in TCP_CLOSE_WAIT and TCP_CLOSING, which can break
out of switch too. Duh, do specs say something about segments with seqs
above fin? I do not remember.

Alexey
