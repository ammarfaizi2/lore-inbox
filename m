Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSFLWWL>; Wed, 12 Jun 2002 18:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSFLWWK>; Wed, 12 Jun 2002 18:22:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37131 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316530AbSFLWWK>; Wed, 12 Jun 2002 18:22:10 -0400
Message-ID: <3D07C977.7090603@zytor.com>
Date: Wed, 12 Jun 2002 15:21:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
In-Reply-To: <5.1.0.14.2.20020612155646.048fd520@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611155046.00af3980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612155646.048fd520@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612192802.045b08c0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612214327.04590b70@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
>>
>> Note that there is no requirement that we're still on cpu "cpu" when
>> we allocate the buffer.  Furthermore, if we fail, we just loop right
>> back to the top.
> 
> 
> What is the point though? Why not just:
> 
>         if (!unlikely(decompression_buffers)) {
>                 down_sem();
>                 allocate_decompression_buffers();
>                 up_sem();
>         }
> 
> And be done with it?
> 
> I don't see any justification for the increased complexity...
> 

Race condition -- you have to drop out of the critical section before
you grab the allocation sempahore, and another CPU can grab the
semaphore in that time.

Thus, the buffers might appear right under your nose.

	-hpa


