Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130559AbQLRW32>; Mon, 18 Dec 2000 17:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130701AbQLRW3W>; Mon, 18 Dec 2000 17:29:22 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:2974 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S130559AbQLRW3E>; Mon, 18 Dec 2000 17:29:04 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Jamie Lokier" <lk@tantalophile.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: /dev/random: really secure?
Date: Mon, 18 Dec 2000 13:58:37 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKOEJJMIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20001218213801.A19903@pcep-jamie.cern.ch>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Schwartz wrote:

> > The code does its best to estimate how much actual entropy it
> > is gathering.

> A potential weakness.  The entropy estimator can be manipulated by
> feeding data which looks random to the estimator, but which is in fact
> not random at all.

> -- Jamie

	Sort of, but not really. You are correct to the extent that it's possible
for someone to make the RNG think it has somewhat more actualy entropy than
it actually has. However, you can't directly feed seeds into the RNG anyway
without root access.

	The process of feeding those seeds into the RNG would inject some actual
entropy at the same time. And so long as the RNG was ever properly seeded,
it will always produce cryptographically secure random numbers no matter
what.

	Even if it's not properly seeded, it doesn't take long before the machine
accumulates enough entropy to be cryptographically secure. So there is only
a brief window of vulnerability after the machine is started and before it
has accumulated sufficient entropy.

	During that window, the amount of entropy present might be underestimated.
The simple fix is for programs that really need good entropy to be extra
conservative within a few minutes of startup.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
