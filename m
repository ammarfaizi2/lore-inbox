Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263289AbRFAPNg>; Fri, 1 Jun 2001 11:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263292AbRFAPN0>; Fri, 1 Jun 2001 11:13:26 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:5814 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S263289AbRFAPNR>; Fri, 1 Jun 2001 11:13:17 -0400
Date: Fri, 1 Jun 2001 17:13:08 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for
In-Reply-To: <E155pmD-0000Zv-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106011632290.18082-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ OK, this time I cc'ed netdev 8-) ]

On Fri, 1 Jun 2001, Alan Cox wrote:

> Please re-read your comment. Then think about it. Then tell me how rate
> limiting differs from caching to the application.

For caching, the kernel establishes the rate with which the info is
updated. There's nothing wrong, but how is the application to know if the
value is actual or cached (from when, until when) ? That means that a
single application that needs data more often than the caching rate will
get bogus data and not know about it.

With rate limiting, you always get new values, unless the limit is
exceeded. When the limit is exceeded, you log and:
- block any request until some timer is expired. The application can
detect that it's been blocked and react. You can detect if there are
several calls waiting and return the same value to all.
- return error until some timer is expired. The application can again
detect that.
In both cases, the application is also capable of guessing the value of
the delay.

For one application which follows the rules (doesn't need data more often
than the caching rate or doesn't exceed the rate limit) there is no
difference, I agree. But when somebody is playing tricks while you need
data, you have the chance of detecting this by using rate limits.

And yes, I agree that either of them (cache or rate limit) should be
modifiable through proc entry/ioctl/whatever.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De







