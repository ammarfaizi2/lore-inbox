Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281836AbRK1AfI>; Tue, 27 Nov 2001 19:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281833AbRK1Ae7>; Tue, 27 Nov 2001 19:34:59 -0500
Received: from mail.myrio.com ([63.109.146.2]:17910 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S281824AbRK1Aej>;
	Tue, 27 Nov 2001 19:34:39 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CAE0@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Andrew Morton'" <akpm@zip.com.au>
Cc: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: RE: Unresponiveness of 2.4.16
Date: Tue, 27 Nov 2001 16:33:56 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've running 2.4.16 with this VM patch combined with your
2.4.15-pre7-low-latency patch from www.zip.com.au.  (it applied with a
little fuzz, no rejects). Is this a combination that you would feel
comfortable with?

So far it hasn't blown up on me, and in fact seems very quick and
responsive.  

Unless I hear a "No, don't do that!", I'm going to push this kernel into
testing for our video applications...

Thanks!

Torrey Hoffman
torrey.hoffman@myrio.com

Andrew Morton wrote:
[...] 
> Description:
> 
> - Account for locked as well as dirty buffers when deciding
>   to throttle writers.
> 
> - Tweak VM to make it work the inactive list harder, before starting
>   to evict pages or swap.
> 
> - Change the elevator so that once a request's latency has
>   expired, we can still perform merges in front of that
>   request.  But we no longer will insert new requests in
>   front of that request.  
> 
> - Modify elevator so that new read requests do not have
>   more than N write requests placed in front of them, where
>   N is tunable per-device with `elvtune -b'.
> 
>   Theoretically, the last change needs significant alterations
>   to the readhead code.  But a rewrite of readhead made negligible
>   difference (I wasn't able to trigger the failure scenario).
>   Still crunching on this.
