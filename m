Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQLRUap>; Mon, 18 Dec 2000 15:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130359AbQLRUae>; Mon, 18 Dec 2000 15:30:34 -0500
Received: from magic.adaptec.com ([208.236.45.80]:54677 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S129908AbQLRUa2>; Mon, 18 Dec 2000 15:30:28 -0500
Message-ID: <E9EF680C48EAD311BDF400C04FA07B612D4DA4@ntcexc02.ntc.adaptec.com>
From: "Boerner, Brian" <Brian_Boerner@adaptec.com>
To: "'linux-kernel@vger.redhat.com'" <linux-kernel@vger.kernel.org>
Subject: Disabling interrupts in 2.4.x
Date: Mon, 18 Dec 2000 14:57:19 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still trying to get the aacraid driver up and running on 2.4 and have
worked it down to this final problem. It appears that interrupts are not
being disabled properly using spin_lock_irqsave. I'm using 2.4.0-test11.

I make this call:
	spin_lock_irqsave ( &(SpinLock->spin_lock), SpinLock->cpu_flags);

where SpinLock is of type pointer to an OS_SPINLOCK structure defined as:

typedef _OS_SPINLOCK {
	spinlock_t	spin_lock;
	unsigned 	cpu_lock_count[NR_CPUS];
	long 		cpu_flag;
	long		lockout_count;
} OS_SPINLOCK;


This is the same call that I was making in 2.2.x kernel and don't have any
problems.

I would expect this function to disable interrupts, but given the scale of
change between 2.2.x spinlock.h and 2.4.x spinlock.h I'm just not sure
anymore. 

The only thing I am sure of is that interrupts are simply not disabled.

I've also looked at some other scsi drivers that are disabling interrupts
and they appear to be making similar calls to spin_lock_irqsave.

Does anyone have any suggestions for debugging this? Is there a call that
can be made to find out if interrupts are actually disabled?

Brian M. Boerner
System Software Developer
Adaptec, Inc.
Nashua, NH 03060

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
