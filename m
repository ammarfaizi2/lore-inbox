Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbTBUBVy>; Thu, 20 Feb 2003 20:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTBUBVy>; Thu, 20 Feb 2003 20:21:54 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:9880 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264739AbTBUBVx>; Thu, 20 Feb 2003 20:21:53 -0500
Message-Id: <5.1.0.14.2.20030220172624.0d4c5070@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 20 Feb 2003 17:31:43 -0800
To: "David S. Miller" <davem@redhat.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: ioctl32 consolidation
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       ak@suse.de
In-Reply-To: <20030220.163619.133744671.davem@redhat.com>
References: <5.1.0.14.2.20030220145240.0d449118@mail1.qualcomm.com>
 <20030220223119.GA18545@elf.ucw.cz>
 <5.1.0.14.2.20030220145240.0d449118@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:36 PM 2/20/2003, David S. Miller wrote:
>   From: Max Krasnyansky <maxk@qualcomm.com>
>   Date: Thu, 20 Feb 2003 14:56:22 -0800
>   
>   Eventually we'll be able to kill ugly mess like arch/sparc64/kernel/ioctl32.c.
>   That stuff really belongs to the actual subsystems that implement those ioctls.
>
>Not really possible with things like SIOCDEVPRIVATE...
>Those need special processing and even that is insufficient.
Hmm. It seems to that all you need for SIOCDEVPRIVATE is ability to register
ranges of ioctls. 
i.e. something like this
        int register_ioctl32_conversion_rage(uint start, uint end, handler);

net/core/dev.c
        register_ioctl32_conversion_range(SIOCDEVPRIVATE, SIOCDEVPRIVATE + 15, siocdevprivate_ioctl);

Am I missing something here ?

Max

