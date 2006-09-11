Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWIKKRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWIKKRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIKKRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:17:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:16072 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750700AbWIKKRf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 06:17:35 -0400
Message-ID: <450537B6.1020509@fr.ibm.com>
Date: Mon, 11 Sep 2006 12:17:26 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, containers@lists.osdl.org,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch -mm] update mq_notify to use a struct pid
References: <45019CC3.2030709@fr.ibm.com> <m18xktkbli.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xktkbli.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Cedric Le Goater <clg@fr.ibm.com> writes:
> 
>> message queues can signal a process waiting for a message.
>>
>> this patch replaces the pid_t value with a struct pid to avoid pid wrap
>> around problems.
>>
>> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Andrew Morton <akpm@osdl.org>
>> Cc: containers@lists.osdl.org
> 
> Signed-off-by: Eric Biederman <ebiederm@xmission.com>
> 
> I was just about to send out this patch in a couple more hours.

Well, you did the same with the usb/devio.c and friends :)

> So expect the fact we wrote the same code is a good sign :)

How does oleg feel about it ? I've seen some long thread on possible race
conditions with put_pid() and solutions with rcu. I didn't quite get all of
it ... it will need another run for me.


On the "pid_t to struct pid*" topic:

* I started smbfs and realized it was useless.

* in the following, the init process is being killed directly using 1. I'm
not sure how useful it would be to use a struct pid. To begin with, may be
they could use a :

	kill_init(int signum, int priv)

./arch/mips/sgi-ip32/ip32-reset.c
./arch/powerpc/platforms/iseries/mf.c
./drivers/parisc/power.c
./drivers/char/snsc_event.c
./kernel/sys.c
./kernel/sysctl.c
./drivers/char/nwbutton.c
./drivers/s390/s390mach.c

* some more drivers,
* some more kthread to convert


C.
