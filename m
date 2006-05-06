Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWEFIa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWEFIa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 04:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWEFIa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 04:30:28 -0400
Received: from www.osadl.org ([213.239.205.134]:57772 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751163AbWEFIa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 04:30:27 -0400
Subject: Re: 2.6.17-rc3-mm1
From: Thomas Gleixner <tglx@linutronix.de>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <20060505150509.GA16562@ens-lyon.fr>
References: <20060501014737.54ee0dd5.akpm@osdl.org>
	 <40f323d00605030211t78e41d18h298c8be3721a135a@mail.gmail.com>
	 <20060503064816.ef7ec2b7.akpm@osdl.org>
	 <1146665732.27820.75.camel@localhost.localdomain>
	 <20060503144318.GA5505@ens-lyon.fr>  <20060505150509.GA16562@ens-lyon.fr>
Content-Type: text/plain
Date: Sat, 06 May 2006 10:30:38 +0000
Message-Id: <1146911438.7467.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit,

On Fri, 2006-05-05 at 17:05 +0200, Benoit Boissinot wrote:
> @@ -437,6 +438,12 @@ hrtimer_start(struct hrtimer *timer, kti
>  
>  	if (mode == HRTIMER_REL) {
- 		tim = ktime_add(tim, new_base->get_time());
+		ktime_t curr = new_base->get_time();
+		
+		tim = ktime_add(tim, curr);
+

Can you change the debug that way? So we have the values which are
added. Please print out new_base->id too.

> and when urxvtd hanged I had the following in dmesg:
> [  356.696000] urxvtd: empty nanosleep 356726124322 17948911854451
> 
> So I suppose something is wrong in ktime_add()

Well, ktime_add is adding two 64 bit values.

The delta between the two values is 0xFFFFFFB3451. That looks like the
timekeeping on your box is screwed by 0x100000000000. 

John, any idea ?

	tglx


