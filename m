Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRCZOyV>; Mon, 26 Mar 2001 09:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131538AbRCZOyM>; Mon, 26 Mar 2001 09:54:12 -0500
Received: from smtp.alcove.fr ([212.155.209.139]:37392 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S131344AbRCZOxx>;
	Mon, 26 Mar 2001 09:53:53 -0500
Date: Mon, 26 Mar 2001 16:52:23 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Nigel Gamble <nigel@nrg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use semaphore for producer/consumer case...
Message-ID: <20010326165223.F15689@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20010323130722.A8916@come.alcove-fr> <Pine.LNX.4.05.10103231541010.6461-100000@cosmic.nrg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.05.10103231541010.6461-100000@cosmic.nrg.org>; from nigel@nrg.org on Fri, Mar 23, 2001 at 03:52:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 03:52:54PM -0800, Nigel Gamble wrote:

> For the producer/consumer case, you want to initialize the semaphore to
> 0, not 1 which DECLARE_MUTEX(sem) does.  So I would use
> 
> __DECLARE_SEMAPHORE_GENERIC(sem, 0)

You're right that the DECLARE_MUTEX does not (entirely) do the job, 
but I set manually the value of sem->count:
> > 		atomic_set(&sem->count, -10);

> Then consumer could be:
> 		/* Wait for 10 items to be produced */
> 		for (i = 0; i < 10; i++)
> 			down(&sem);

IMHO, this will not work, because the producer could be issuing
more than one 'up(&sem)' at the time...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|------------- Ingénieur Informatique Libre --------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|----------- Alcôve, l'informatique est libre ------------|
