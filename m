Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRCWMIb>; Fri, 23 Mar 2001 07:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130770AbRCWMIV>; Fri, 23 Mar 2001 07:08:21 -0500
Received: from smtp.alcove.fr ([212.155.209.139]:53770 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S130768AbRCWMIF>;
	Fri, 23 Mar 2001 07:08:05 -0500
Date: Fri, 23 Mar 2001 13:07:22 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-kernel@vger.kernel.org
Subject: Use semaphore for producer/consumer case...
Message-ID: <20010323130722.A8916@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I want to use a semaphore for the classic producer/consumer case
(put the consumer to wait until X items are produced, where X != 1).

If X is 1, the semaphore is a simple MUTEX, ok.

But if the consumer wants to wait for several items, it doesn't
seem to work (or something is bad in my code).

What is wrong in the following ?

	DECLARE_MUTEX(sem);

	producer() {
		/* One item produced */
		up(&sem);
	}
	
	consumer() {
		/* Let's wait for 10 items */
		atomic_set(&sem->count, -10);
	
		/* This starts the producers, they will call producer()
		   some time in the future */
		start_producers();
	
		/* Wait for completion */
		down(&sem);
	}

I can get around this by using a mutex and a separate atomic_t 
'count' variable, but it's more a workaround that a solution...

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|------------- Ingénieur Informatique Libre --------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|----------- Alcôve, l'informatique est libre ------------|
