Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRBRTsf>; Sun, 18 Feb 2001 14:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129192AbRBRTs0>; Sun, 18 Feb 2001 14:48:26 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:54023 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129184AbRBRTsM>;
	Sun, 18 Feb 2001 14:48:12 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102181948.WAA27407@ms2.inr.ac.ru>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
To: chris@scary.beasts.org (Chris Evans)
Date: Sun, 18 Feb 2001 22:48:00 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <Pine.LNX.4.30.0102181935130.31140-100000@ferret.lmh.ox.ac.uk> from "Chris Evans" at Feb 18, 1 07:37:33 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> .. unless that page was partially written, in which case a short write
> count is returned (rather than a timeout error), and the loop goes around
> again.

sendfile() does not return on partial write and tries to push more
until error. On fast link it most likely succeeds, so that it is unkillable
even with SIGKILL.


> Which is good, because SO_SNDTIMEO is an inactivity monitor.

Then why did you blame? 8)8)

I do not think so. It is rather scheduling breaker. If connection
is idle 99% of time, but wakes each sndtimeo-1usec, it must yuild,
otherwise thread is lost for production.

Alexey
