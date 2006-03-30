Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWC3NX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWC3NX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWC3NX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:23:56 -0500
Received: from morbo.e-centre.net ([66.154.82.3]:50681 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP id S932205AbWC3NXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:23:55 -0500
X-ASG-Debug-ID: 1143725028-11432-37-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: jiffies doesn't increase while doing mdelay() ?
Subject: Re: jiffies doesn't increase while doing mdelay() ?
From: Arjan van de Ven <arjan@infradead.org>
To: James Yu <cyu021@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <60bb95410603292152l7597259dx28eaec77ebc5dfdf@mail.gmail.com>
References: <60bb95410603292150r6448596clbef348e1bededdaf@mail.gmail.com>
	 <60bb95410603292152l7597259dx28eaec77ebc5dfdf@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 15:23:47 +0200
Message-Id: <1143725027.3062.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10269
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 13:52 +0800, James Yu wrote:
> Dear all,
> 
> I am doing the following in a kernel thread :
> 
> ===== code segment=====
> prink("before mdelay:%d, ", jiffies);
> mdelay(300); // delay 300ms
> printk("after mdelay:%d\n", jiffies);
> ===== code segment=====
> 
> However, jiffies before and after doing mdelay are the same!!!
> Can someone please explain why jiffies doesn't change ?

first of all you should use msleep() not mdelay() for such long
delays...
second if you have interrupts disables (for example via
spin_lock_irqsave) this is normal (and the reason why your code is
evil): The timer interrupt that normally increments jiffies can't happen
because you disabled it..

