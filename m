Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWDRNbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWDRNbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWDRNbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:31:08 -0400
Received: from mail.advantech.ca ([207.35.60.239]:8226 "EHLO
	exch2k.Advantech.ca") by vger.kernel.org with ESMTP
	id S1750891AbWDRNbH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:31:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Question on Schedule and Preemption
Date: Tue, 18 Apr 2006 09:31:04 -0400
Message-ID: <1A60C93388AFD3419AEE0E20A116D3201CFDA7@exch2k>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on Schedule and Preemption
Thread-Index: AcZiuPetHrWza4uSTC+fW7zI7/054gAMXcJw
From: "Michael Guo" <Michael.Guo@advantechAMT.com>
To: "Liu haixiang" <liu.haixiang@gmail.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 The comments above the piece of code give some hints about the sane checking. When call "schedule" for process scheduling, make sure that context isn't atomic. That is, schedule should be called in a safe place such as spinlock free etc. And you can also read do_exit() code to get more detailed information.


   

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Liu haixiang
Sent: Tuesday, April 18, 2006 3:23 AM
To: linux-kernel@vger.kernel.org
Subject: Question on Schedule and Preemption


Hi All,

Now I am developing the driver on Linux kernel 2.6.11. And I met the
problem that kernel will dump my stack from time to time. And the
kernel log will give me messages like "scheduling while atomic: ...".

Then I found the code in sched.c:

if (likely(!current->exit_state)) {
	if (unlikely(in_atomic())) {
		printk(KERN_ERR "scheduling while atomic: "
			"%s/0x%08x/%d\n",
			current->comm, preempt_count(), current->pid);
		dump_stack();
	}
}

Anybody can explain above code for me?

Thanks

best regards

Haixiang Liu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
