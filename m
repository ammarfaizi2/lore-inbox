Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUFLWIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUFLWIf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 18:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUFLWIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 18:08:35 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:40854 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S264936AbUFLWIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 18:08:32 -0400
Message-ID: <40CB7EBD.2020109@linuxmail.org>
Date: Sun, 13 Jun 2004 08:07:57 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: herbert@gondor.apana.org.au, pavel@suse.cz, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix memory leak in swsusp
References: <20040609130451.GA23107@elf.ucw.cz>	<E1BYN8O-0008Vg-00@gondolin.me.apana.org.au>	<20040610105629.GA367@gondor.apana.org.au>	<20040610212448.GD6634@elf.ucw.cz>	<20040610233707.GA4741@gondor.apana.org.au>	<20040611094844.GC13834@elf.ucw.cz>	<20040611101655.GA8208@gondor.apana.org.au>	<20040611102327.GF13834@elf.ucw.cz>	<20040611110314.GA8592@gondor.apana.org.au>	<40CA75CA.2030209@linuxmail.org> <20040611210059.2522e02d.akpm@osdl.org>
In-Reply-To: <20040611210059.2522e02d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Andrew Morton wrote:
> Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> 
>> We were avoiding the use of memcpy because it messes up the preempt count with 3DNow, and 
>> potentially as other unseen side effects. The preempt could possibly simply be reset at resume time, 
>> but the point remains.
> 
> 
> eh?  memcpy just copies memory.  Maybe your meant copy_*_user()?

At some stage, you copy the page that contains the preempt count for the process that is doing the 
suspending. If you use memcpy on a 3Dnow machine, the preempt count is incremented prior to doing 
the copy of the page. Then, at resume time, it is one too high.

Regards,

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (417) 100 574 (mobile)
