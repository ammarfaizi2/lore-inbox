Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVHRWor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVHRWor (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVHRWor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:44:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5273 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932492AbVHRWoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:44:46 -0400
Subject: Re: Environment variables inside the kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linh Dang <linhd@nortel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <wn5slx75cjs.fsf@linhd-2.ca.nortel.com>
References: <4fec73ca050818084467f04c31@mail.gmail.com>
	 <m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local>
	 <wn5slx75cjs.fsf@linhd-2.ca.nortel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Aug 2005 00:12:28 +0100
Message-Id: <1124406748.20755.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-18 at 14:23 -0400, Linh Dang wrote:
> They're in current process's vm. You just have to parse it yourself.
> 
> something along the (untested) lines:
> 
>         struct mm_struct *mm = current ? get_task_mm(current) : NULL;
> 
>         if (mm) {
>                 unsigned env_len = mm->env_end - mm->env_start;
>                 char* env = kmalloc(env_len, GFP_KERNEL);


That is the environment passed to the application, not the environment
it is running with. Only the application knows where that is, and once
you do things like putenv() it becomes rather relevant.

Essentially environment is user space business and you can't get at it
from the kernel.

