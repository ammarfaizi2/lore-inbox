Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276148AbRI1QSm>; Fri, 28 Sep 2001 12:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276149AbRI1QSW>; Fri, 28 Sep 2001 12:18:22 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:4873 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276148AbRI1QSS>;
	Fri, 28 Sep 2001 12:18:18 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109281618.UAA04122@ms2.inr.ac.ru>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
To: mingo@elte.hu
Date: Fri, 28 Sep 2001 20:18:20 +0400 (MSK DST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, andrea@suse.de
In-Reply-To: <Pine.LNX.4.33.0109261729570.5644-200000@localhost.localdomain> from "Ingo Molnar" at Sep 26, 1 06:44:03 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  - removed 'mask' handling from do_softirq() - it's unnecessery due to the
>    restarts. this further simplifies the code.

Ingo, but this means that only the first softirq is handled.
"mask" implements round-robin and this is necessary.


>  - '[ksoftirqd_CPU0]' is confusing on UP systems, changed it to
>    '[ksoftirqd]' instead.

It is useless to argue about preferences, but universal naming scheme
looks as less confusing yet. :-)


Generally, I dislike this patch. It is utterly ugly.

Also, you did not assure me that you interpret problem correctly.
netif_rx() is __insensitive__ to latencies due to blocked softirq restarts.
It stops spinning only when it becomes true cpu hog. And scheduling ksoftirqd
is the only variant here.

Most likely, your problem will disappear when you renice ksoftirqd
to higher priority f.e. equal to priority of tux threads.

Alexey
