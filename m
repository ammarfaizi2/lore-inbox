Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVKXQEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVKXQEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVKXQEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:04:42 -0500
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:48121 "EHLO
	mail.shipmail.org") by vger.kernel.org with ESMTP id S1751215AbVKXQEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:04:41 -0500
Message-ID: <36746.192.138.116.230.1132848279.squirrel@192.138.116.230>
In-Reply-To: <200511240731.56147.jbarnes@virtuousgeek.org>
References: <1132807985.1921.82.camel@mindpipe>   
 <1132829378.3473.11.camel@mindpipe>    
 <19379.192.138.116.230.1132836621.squirrel@192.138.116.230>   
 <200511240731.56147.jbarnes@virtuousgeek.org>
Date: Thu, 24 Nov 2005 17:04:39 +0100 (CET)
Subject: Re: 2.6.14-rt4: via DRM errors
From: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>
To: "Jesse Barnes" <jbarnes@virtuousgeek.org>
Cc: dri-devel@lists.sourceforge.net, "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-BitDefender-Spam: No (0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> At one point I was about to implement a scheme for via with a number
>> of similar locks, one for each independent function on the video
>> chip, Like 2D, 3D, Mpeg decoder, Video scaler 1 and 2, so that they
>> didn't have to wait for  eachother. The global lock would then only
>> be taken to make sure that no drawables were touched by the X server
>> or other clients while the lock was held, which would be compatible
>> with how the X server works today. Never got around to do that,
>> however, but the mpeg decoders have a futex scheme to prevent clients
>> stepping on eachother. With that it is possible to have multiple
>> clients use the same hw decoder.
>
> Sounds interesting, but that would be card specific, right?  I mean, on
> some cards the 2d and 3d locks would have to be the same because of
> shared state or whatever, for example.
>
> Jesse
>
Yes. you're right. The idea was to provide an implementation of a set of
locks and context switch / idle hooks that the device-specific driver
could use for whatever part of the chip it wanted, _if_ it wanted to.
When a command stream is submitted, the driver would need to check that
there are only commands for locked part of the chip in the stream. There
would also need to be a mechanism to check whether there are pending DMA
commands corresponding to a particular lock, to avoid having to make DMA
quiescent in unnecessary cases. Lock values would reside in a separate
shared memory area. However, a bit complicated and too little time.

/Thomas.


