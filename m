Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131595AbQKZWPz>; Sun, 26 Nov 2000 17:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132870AbQKZWPp>; Sun, 26 Nov 2000 17:15:45 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:22032 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S131595AbQKZWP2>; Sun, 26 Nov 2000 17:15:28 -0500
Date: Sun, 26 Nov 2000 15:42:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: PCMCIA 3.1.22 needs patch for kernels > 2.2.18-23
Message-ID: <20001126154216.A1424@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Hinds/Linux,

PCMCIA 3.1.22 requires that the defines in /include/pcmcia/k_compat.h
for init_waitqueue_head(n) and set_current_state(n) be removed in order
to build correctly against 2.2.18-23.  

Offending code attached.  This probably needs somethig better than the 
LINUX_KERNEL_VERSION macro to avoid this problem in the future.

:-)

Jeff

in /include/pcmcia/k_compat.h

/*********
#if (LINUX_VERSION_CODE < VERSION(2,2,18))
#if (LINUX_VERSION_CODE < VERSION(2,0,16))
#define init_waitqueue_head(p)  (*(p) = NULL)
#else
#define init_waitqueue_head(p)  init_waitqueue(p)
#endif
typedef struct wait_queue *wait_queue_head_t;
#endif
*******/

and


#if (LINUX_VERSION_CODE < VERSION(2,1,0))
#define __set_current_state(n) \
    do { current->state = TASK_INTERRUPTIBLE; } while (0)
#elif (LINUX_VERSION_CODE < VERSION(2,2,18))
//#define __set_current_state(n)  do { current->state = (n); } while (0)
#endif
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
