Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310369AbSCBNAu>; Sat, 2 Mar 2002 08:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310374AbSCBNAl>; Sat, 2 Mar 2002 08:00:41 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:13326 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S310369AbSCBNAa>;
	Sat, 2 Mar 2002 08:00:30 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200203021259.PAA20250@ms2.inr.ac.ru>
Subject: Re: OOPS: Multipath routing 2.4.17
To: ja@ssi.bg (Julian Anastasov)
Date: Sat, 2 Mar 2002 15:59:49 +0300 (MSK)
Cc: kain@kain.org, linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <Pine.LNX.4.44.0203012316120.1420-100000@u.domain.uli> from "Julian Anastasov" at Mar 2, 2 00:27:40 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> w = jiffies % fi->fib_power;

	power = fi->fib_power;
	barrier();
	if (power) ...

Such thing are made in this way.

> 	write_lock(&fib_info_lock);

DO NOT MAKE THIS! fib_info_lock must not be acquired in this context,
it will lockup. Just add a new lock, which is protected wrt softirqs.

Alexey
