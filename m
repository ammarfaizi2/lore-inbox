Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265861AbTF3Tzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265866AbTF3Tzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 15:55:32 -0400
Received: from web20003.mail.yahoo.com ([216.136.225.48]:34828 "HELO
	web20003.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265861AbTF3Tza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 15:55:30 -0400
Message-ID: <20030630200949.96698.qmail@web20003.mail.yahoo.com>
Date: Mon, 30 Jun 2003 13:09:49 -0700 (PDT)
From: Raghava Raju <vraghava_raju@yahoo.com>
Subject: Re: delegating to a cpu
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1056901638.1720.3.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

Driver is in development stage, so I have given u an 
overview of how my interrupt handler looks like.
As u can see below, I am doing some minimal processing
in ISR and scheduling a tasklet for reamining
work(like allocating buffers and cleanup). 
But problem with this is that tasklet ends up on same
cpu. I want some method where by I can make use of 
second cpu, so that second cpu does the work what 
tasklet is doing(i.e allocating buffers and clean up).

Please don't give a solution based on irq affinity to
second cpu, as we have only one interrupt.


void my_isr(int irq, void *dev_id, struct pt_regs
*regs)
{

/*Mask interrupts on the device */
write(register, nomore interrupts);

/*do some minimal amount of processing to 
read data provided by the device*/
do_basic_read(dev_id);

/*schedule tasklet and give it remaining work.*/
tasklet_schedule();

/*Unmask interrupts on device*/
write(register, start generating interrupts);

}

Regards
Raghava.

--- Arjan van de Ven <arjanv@redhat.com> wrote:
> On Sun, 2003-06-29 at 17:34, Raghava Raju wrote:
> > Hi, 
> > 
> > Currently interrupt handler in our driver uses
> > tasklet to process some of less important info
> > to save some interrupt time. But problem is that
> > tasklet ends up in the same cpu, and second  cpu 
> > is not taking much of the work. 
> > 1) Is there any mechanism to delegate the less
> > important work to other cpu an example would
> really 
> > help.
> 
> you don't give a lot of information about what you
> are trying to do...
> could you post an URL to your driver source, that's
> the easiest way to
> give this information...
> 

> ATTACHMENT part 2 application/pgp-signature
name=signature.asc



__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
