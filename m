Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRB0Ufn>; Tue, 27 Feb 2001 15:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129190AbRB0Uff>; Tue, 27 Feb 2001 15:35:35 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:35076 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129111AbRB0UfS>;
	Tue, 27 Feb 2001 15:35:18 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102272035.XAA21341@ms2.inr.ac.ru>
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
To: rmk@arm.linux.ORG.UK (Russell King)
Date: Tue, 27 Feb 2001 23:35:12 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200102271002.f1RA2B408058@brick.arm.linux.org.uk> from "Russell King" at Feb 27, 1 01:15:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> netstat on isdn-gw shows the following:
> 
> 	Proto Recv-Q Send-Q Local Address           Foreign Address         State
> 	tcp    72868      0 isdn-gw.piltdown.a:1023 pilt-gw.piltdown.at:ssh ESTABLISHED
plus
> select(4, [3], [3], NULL, NULL)         = 2 (in [3], out [3])


> Maybe there is a race condition or missing wakeup in the TCP code?

Moreover, even not _one_ wakeup is missing. At least two, because
wakeups in read and write are separate and you have stuck in both directions.
8)8)

Well, if it was one I would start to dig ground inside tcp instantly.
But as soon as two of them are missing, I have to suspect wake_up itself.
At least, we had such bugs there until 2.4.0.

Alexey
