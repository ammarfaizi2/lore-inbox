Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288977AbSAFQGZ>; Sun, 6 Jan 2002 11:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288978AbSAFQGP>; Sun, 6 Jan 2002 11:06:15 -0500
Received: from 200-MADR-X122.libre.retevision.es ([62.83.19.200]:6528 "HELO
	mumismo.wanadoo.es") by vger.kernel.org with SMTP
	id <S288977AbSAFQF6>; Sun, 6 Jan 2002 11:05:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jordi <mumismo@wanadoo.es>
To: Momchil Velikov <velco@fadata.bg>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]: 2.5.1pre9 change several if (x) BUG to BUG_ON(x)
Date: Sun, 6 Jan 2002 17:10:27 +0100
X-Mailer: KMail [version 1.3.1]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <E16NEar-0005Ln-00@the-village.bc.nu> <878zbba629.fsf@fadata.bg>
In-Reply-To: <878zbba629.fsf@fadata.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020106161028.5E507801C1@mumismo.wanadoo.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 January 2002 15:48, Momchil Velikov wrote:

>
> Alan> Your patch looks wrong (ook ook! 8)) - if you build without BUG
> enabled you Alan> don't make various function calls with your change.
> BUG_ON has the C nasty Alan> assert() does that makes it a horrible
> horrible idea and its unfortunate Alan> it got put in.
>
> Alan> 	BUG_ON(function(x,y))
>
> #ifdef DEBUG
> #define BUG_ON(x) if (x) BUG()
> #else
> #define BUG_ON(x) (void)(x)
> #endif

Sorry but in 2.5.2 pre9 (i make a mistake in the topic, is 2.5.2pre9 , no 
2.5.1pre9):
kernel.h:
#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)

So i don't understand Alan's complaims, if i understands it well, BUG_ON() is 
just a optimization of BUG function. 
So in simple "if (condition) BUG()" cases i think it will allways be replaced 
, of course in "if (condition) someWork; BUG()" we can't.
