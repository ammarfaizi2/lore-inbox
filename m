Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270721AbRIAOgu>; Sat, 1 Sep 2001 10:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270748AbRIAOgl>; Sat, 1 Sep 2001 10:36:41 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:34573 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S270721AbRIAOga>;
	Sat, 1 Sep 2001 10:36:30 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109011436.SAA18432@ms2.inr.ac.ru>
Subject: Re: Lost TCP retransmission timer
To: val@nmt.edu (Val Henson)
Date: Sat, 1 Sep 2001 18:36:35 +0400 (MSK DST)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010830161139.A18224@boardwalk> from "Val Henson" at Aug 30, 1 04:11:39 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 2.4.6 machine pushes lots of data on _first_ TCP connection after boot

Lots? I see only about 24K of data transmitted in both your samples.

Actually, the problem is more or less clear from your /proc/net/tcp.
You use some funny device or netfilter plugin, which leak memory.
You can look into 7th column of /proc/net/tcp to estimate amount of leaked
buffers. When it reaches ~15, connection stalls. Seems, it raises
monotonically, so that it looks like all the buffers leak.

What is output device?

Alexey
