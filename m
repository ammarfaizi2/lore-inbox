Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTEELgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 07:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbTEELgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 07:36:04 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:55564 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S262150AbTEELgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 07:36:02 -0400
Message-ID: <3EB65028.8080402@torque.net>
Date: Mon, 05 May 2003 21:51:04 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: illegal context for sleeping ... rmmod ide-cd + ide-scsi
References: <3EB62347.8020109@torque.net> <20030505020104.0abc66ba.akpm@digeo.com>
In-Reply-To: <20030505020104.0abc66ba.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Douglas Gilbert <dougg@torque.net> wrote:
> 
>>In lk 2.5.69 (and in 68) both the ide-cd and ide-scsi
>>modules generate a "sleeping function called from illegal
>>context" stack trace when removed.
>>
>>After "rmmod ide-cd" this appears:
>>  Debug: sleeping function called from illegal context
>>         at include/asm/semaphore.h:119
>>  Call Trace:
>>   [<c011dcec>] __might_sleep+0x5c/0x70
> 
> 
> ide_unregister_subdriver() does spin_lock_irqsave(&ide_lock), then
> calls auto_remove_settings(), which does down(&ide_setting_sem);
> 
> A simple fix might be:

Andrew,
Thanks. That patch clears the reported problem.

Doug Gilbert

