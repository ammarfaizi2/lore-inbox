Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313660AbSEARQ1>; Wed, 1 May 2002 13:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313690AbSEARQ0>; Wed, 1 May 2002 13:16:26 -0400
Received: from [212.18.235.99] ([212.18.235.99]:13583 "EHLO street-vision.com")
	by vger.kernel.org with ESMTP id <S313660AbSEARQ0>;
	Wed, 1 May 2002 13:16:26 -0400
From: Justin Cormack <kernel@street-vision.com>
Message-Id: <200205011716.g41HGNS24162@street-vision.com>
Subject: Re: raid1 performance
To: kentborg@borg.org (Kent Borg)
Date: Wed, 1 May 2002 18:16:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020501130127.A10936@borg.org> from "Kent Borg" at May 01, 2002 01:01:27 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Lemme see if I am getting closer.  
> 
> When reading the disk there will be head seeks necessary.  When there
> are two disks, each with its own complete copy of all the data, there
> is no reason to keep the two disks' heads in the same place.  If their
> heads are in different places, a read can be issued to the disk whose
> heads are closer to the desired location.

yes. Look at raid1.c: the code is quite clear. Older versions didnt.

> This then brings up two more questions:
> 
>   1. Does the OS even know where the heads are in a modern IDE disk?

Not really. But there is probably a vague correspondence. Especially if
you havent remapped any bad sectors.

>   2. Is "closer" any more finely grained than a binary
>      positioned/not-positioned?

I think so. You can see different performance regions on disks (ie they
are faster on the outside for example). You could of course write a program
to test seek times from different areas and build up a real locality map.
It might not be worth it though.

> And I guess another question: How much does RAID 1 help and under what
> kinds of usage?

the latency is noticeably less in some cases, as the seeks should be smaller
on average. I have found this useful sometimes.

Justin
