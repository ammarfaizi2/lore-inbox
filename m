Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQL0Oqb>; Wed, 27 Dec 2000 09:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbQL0OqU>; Wed, 27 Dec 2000 09:46:20 -0500
Received: from 13dyn248.delft.casema.net ([212.64.76.248]:14599 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129572AbQL0OqP>; Wed, 27 Dec 2000 09:46:15 -0500
Message-Id: <200012271415.PAA18730@cave.bitwizard.nl>
Subject: Semaphores slow???
To: linux-kernel@vger.kernel.org
Date: Wed, 27 Dec 2000 15:15:35 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We have a typical semaphore application that has a producer and a
consumer.

Without the semaphores we are limited by the rest of the stuff to
10000 times around the loop per second. That's good.

When we put the "push the semaphore" call in there, the rate drops to
around 8000 per second. I'm not happy about that, but ok. When we add
the "wait for bufferspace" semaphore wait in there, the rate drops to
4000 per second. This is way too low.

Does anybody have an idea why linux semaphores are so slow?

init: 
	sem_init (&write_sem, 1, 0);
	sem_init (&write_buffer_sem, 1, 0);



producer: 

	
	while (1) {
                sem_wait (&write_buffer_sem);
		... 

                sem_post (&write_sem);
        }


consumer: 
	for (i=0;i<nbufs;i++) {
		Create_buffer (i);
		sem_post (&write_buffer_sem);
        }

	while (1) {
                sem_wait (&write_sem);
		... 

                sem_post (&write_buffer_sem);
	}


(pshared == 0 doesn't work: returns error. The manpage claims that
thsi would happen for pshared != 0... )


Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
