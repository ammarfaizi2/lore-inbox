Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129382AbRBLUcK>; Mon, 12 Feb 2001 15:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129724AbRBLUcB>; Mon, 12 Feb 2001 15:32:01 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:46098 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129382AbRBLUbu>;
	Mon, 12 Feb 2001 15:31:50 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102122031.XAA31392@ms2.inr.ac.ru>
Subject: Re: 2.4.1 errors under heavy network load
To: magnus.walldal@b-linc.COM (Magnus Walldal)
Date: Mon, 12 Feb 2001 23:31:17 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <HFEDLHHPHHEOBHLNPJOKMEHECAAA.magnus.walldal@b-linc.com> from "Magnus Walldal" at Feb 12, 1 08:45:07 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Then we did the following tuning attempt:

Please, cat /proc/net/tcp and /proc/net/sockstat
and send result to me (gzipped), together with /proc/sys/net/ipv4/tcp_*
values


> echo "20480" > /proc/sys/net/ipv4/tcp_max_orphans

Also, you want to increase memory allowed for TCP
echo "X/2 X/2 X" > /proc/sys/net/ipv4/tcp_mem
where X is memory in pages.

20480 is a crazy number. Valid applications cannot leave
so much of orphans. Do you understand that this is more than
80MB of wasted memory?


> echo "1" > tcp_orphan_retries

Bad idea. Default value is the lowest possible.


> echo 30 > /proc/sys/net/ipv4/tcp_keepalive_time
> echo 2 > /proc/sys/net/ipv4/tcp_keepalive_probes

Bad idea.



> Oh btw. we got what I think is a "bad one" too...
> Feb 12 16:42:35 mcquack kernel: KERNEL: assertion (tp->lost_out == 0) failed
> at tcp_input.c(1202):tcp_remove_reno_sacks

Absolutely harmless. This is debugging message.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
