Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWA0TGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWA0TGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWA0TGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:06:44 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:44769 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S932367AbWA0TGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:06:44 -0500
Message-ID: <43DA62CC.8090309@wolfmountaingroup.com>
Date: Fri, 27 Jan 2006 11:13:32 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.14 kernels and above copy_to_user stupidity with IRQ disabled
 check
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a good reason someone set a disabled_irq() check on 2.6.14 and 
above for copy_to_user to barf out
tons of bogus stack dump messages if the function is called from within 
a spinlock:

i.e.

 spin_lock_irqsave(&regen_lock, regen_flags);
    v = regen_head;
    while (v)
    {
       if (i >= count)
          return -EFAULT;
                                                                                

       err = copy_to_user(&s[i++], v, sizeof(VIRTUAL_SETUP));
       if (err)
          return err;
                                                                                

       v = v->next;
    }
    spin_unlock_irqrestore(&regen_lock, regen_flags);

is now busted and worked in kernels up to this point.  The error message 
is annoying but non-fatal.

Jeff


