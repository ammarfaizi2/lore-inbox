Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319359AbSIKVks>; Wed, 11 Sep 2002 17:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319361AbSIKVks>; Wed, 11 Sep 2002 17:40:48 -0400
Received: from dsl-213-023-021-043.arcor-ip.net ([213.23.21.43]:9965 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319359AbSIKVkr>;
	Wed, 11 Sep 2002 17:40:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: [RFC] Raceless module interface
Date: Wed, 11 Sep 2002 23:47:45 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Neukum <oliver@neukum.name>, Roman Zippel <zippel@linux-m68k.org>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209101201280.8911-100000@serv> <E17pEpj-0007Up-00@starship> <20020911222614.A12614@kushida.apsleyroad.org>
In-Reply-To: <20020911222614.A12614@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pFKr-0007V7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 23:26, Jamie Lokier wrote:
> Daniel Phillips wrote:
> > Really, that's not so, there are limits.  30 seconds?  Whatever.  
> > Remember, during this time the service provided by the module is
> > unavailable, so this is denial-of-service land.  You could of
> > course put in extra code to abort the unload process on demand,
> > but, hmm, it probably wouldn't work ;-)
> 
> If you're going to do it right, you should fix that denial-of-service by
> waiting until the module has finished unloading and then demand-loading
> the module again.

That doesn't make the DoS go away, it just makes it a little
harder to trigger.  Anyway, one thing we could do if the rest
of the module mechanism is up to it, is know that somebody is
trying to reactivate a module that has just returned from
module_cleanup(), and immediately reactivate it instead of
freeing it, hoping to save some disk activity - if this turns
out to be a real problem, that is.  The null solution is likely
the winner here.

> Ideally, those periodic "rmmod -a" calls should _never_ cause a
> denial-of-service.

Goodness no.  By the way, nobody has asked me how rmmod -a is
to be implemented.  Oh well.

-- 
Daniel
