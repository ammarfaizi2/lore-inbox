Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274920AbRJFDuL>; Fri, 5 Oct 2001 23:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274951AbRJFDuB>; Fri, 5 Oct 2001 23:50:01 -0400
Received: from hermes.toad.net ([162.33.130.251]:38886 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S274920AbRJFDtw>;
	Fri, 5 Oct 2001 23:49:52 -0400
Subject: Question about rtc_lock
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 05 Oct 2001 23:49:54 -0400
Message-Id: <1002340196.813.64.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file arch/i386/kernel/bootflag.c contains this:

-------------------------------------------------
static void __init sbf_write(u8 v)
{
        if(sbf_port != -1)
        {
                v &= ~(1<<7);
                if(!parity(v))
                        v|=1<<7;

                spin_lock(&rtc_lock);
                CMOS_WRITE(v, sbf_port);
                spin_unlock(&rtc_lock);
        }
}
--------------------------------------------------

Does this code run with irqs disabled, or should these
spinlocks be _irq ?

--
Thomas

