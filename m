Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316375AbSEOLqg>; Wed, 15 May 2002 07:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316376AbSEOLqf>; Wed, 15 May 2002 07:46:35 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:62027 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S316375AbSEOLqe>; Wed, 15 May 2002 07:46:34 -0400
Message-ID: <3CE24A34.CEA0CAE0@ukaea.org.uk>
Date: Wed, 15 May 2002 12:44:52 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Anton Altaparmakov <aia21@cantab.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk> <3CE22B2B.5080506@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> The only problem is that having a shared lock between two queues apparently
> doesn't imply that the queues are behaving atomic on the request level
> among each others.

Correct - both queues can be active with I/O in flight at the same
time.  But think about it: if this weren't the case, then the older
kernels (using global io_request_lock) would have had to serialize ALL
I/O, one request-queue active at a time, for every single
block-device...

> Apparenty the "sublimation" of the hwgroup and overall cleanup of
> data structures, just made many people awake and be aware of problems which
> where there already for a very very long time...

I'm not quite sure which problems you mean.  The busy flag prevents any
clash. (But sure, if you change to per-device queues AND you ditch the
busy flag you're screwed.) Where is the problem?

cheers
Neil
