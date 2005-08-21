Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVHUVE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVHUVE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVHUVE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:04:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52936 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751094AbVHUVE4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:04:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UWHSH0f7wlmC9k6OqV7abY/Y7/xV8FQ3bgdrW4TcwZXdEojcPAu0cb4Q0nbDaimR5yE10LDo9UzHxTBH+tPmHd8WaDnUinaCYbAzYC0BlOHrf2pH54cKKODmCZk82TznlZyCUJVR8eLcLdfMsv82Z3fbp9VIPnjfPLTtyGbwcWA=
Message-ID: <84144f0205082113123049afe2@mail.gmail.com>
Date: Sun, 21 Aug 2005 23:12:06 +0300
From: Pekka Enberg <penberg@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: -mm patch] kcalloc(): INT_MAX -> ULONG_MAX
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050821195434.GC5726@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050820193237.GG3615@stusta.de>
	 <84144f0205082112477979b053@mail.gmail.com>
	 <20050821195434.GC5726@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 10:47:13PM +0300, Pekka Enberg wrote:
> > You'll probably get even better code if you change the above to:
> >
> >     if (size != 0 && n > ULONG_MAX / size)
> >
> > Reason being that size is virtually always a constant so the compiler
> > can evaluate the division at compile-time.

On 8/21/05, Adrian Bunk <bunk@stusta.de> wrote:
> I doubt this would make any difference.
> 
> And besides, except in some rare cases, the second argument is a
> sizeof(foo) whose size is already known at compile time.

Yes, that's my point. The second argument (size) is virtually always
sizeof() whereas the first one (n) is sometimes a variable. GCC
currently does not optimize away the division when n is not a
constant.

Looking at 2.6.13-rc6-mm1, we have roughly 15 callers with the first
parameter being a variable. The compiler would be able to get rid of
one comparison and division instruction for each of these so looks
like we could shave off some more bytes...

                            Pekka
