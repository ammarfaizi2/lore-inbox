Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130183AbRBAKvI>; Thu, 1 Feb 2001 05:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130232AbRBAKu7>; Thu, 1 Feb 2001 05:50:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40461 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130183AbRBAKur>; Thu, 1 Feb 2001 05:50:47 -0500
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
To: tleete@mountain.net (Tom Leete)
Date: Thu, 1 Feb 2001 10:50:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), david@linux.com (David Ford),
        sfrost@snowman.net (Stephen Frost),
        linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <3A7915AF.5C9C54CF@mountain.net> from "Tom Leete" at Feb 01, 2001 02:52:15 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OHKN-00047W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > uninlining the code is too high a cost.
> 
> I question that. Athlon does branch prediction on call targets, function
> calls are cheap. 3dnow saves 25%-50% of cycles on a copy. How many function
> calls can be paid for with 1000 cycles or so?
> 
> My patch still inlines the standard string const_memcpy for the case of
> small known length.

We have a very large number of memcpy's of unknown short length (often in
interrupts) that are close to branches. A lot of

	if(foo==NULL)
		return
	memcpy(..

stuff for example.

Im more than happy for someone to do the benches and prove me wrong

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
