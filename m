Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316004AbSEJOVU>; Fri, 10 May 2002 10:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316005AbSEJOVT>; Fri, 10 May 2002 10:21:19 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:50426 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316004AbSEJOVS>; Fri, 10 May 2002 10:21:18 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.3.95.1020510095907.2632A-100000@chaos.analogic.com> 
To: root@chaos.analogic.com
Cc: Keith Owens <kaos@ocs.com.au>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: spin-locks 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 May 2002 15:17:50 +0100
Message-ID: <26626.1021040270@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


root@chaos.analogic.com said:
>  Well, here is code that worked on linux 2.2.17.  Same CPUs, same
> everything... Just a different version of OS...

I suspect your code was protected by the BKL in 2.2.17, not by your 
'spinlocks'.

root@chaos.analogic.com said:
> 	cli
> 	lock
> 	incb	(lockf)		# Bump lock-value 

Ponder what happens if two CPUs get here at the same time. Lock count is 
now two.

> 1:	cmpb	$1,(lockf)	# See if we own it
> 	jnz	1b		# Nope, spin until we do. 

Now they both spin forever.

--
dwmw2


