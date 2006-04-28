Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWD1AEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWD1AEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWD1AEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:04:20 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:9530 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751771AbWD1AEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:04:20 -0400
Date: Thu, 27 Apr 2006 18:03:08 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Compiling C++ modules
In-reply-to: <66grR-2DK-27@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Denis Vlasenko <vda@ilport.com.ua>
Message-id: <44515BBC.4070304@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <65eLE-GJ-21@gated-at.bofh.it> <65zwH-61W-51@gated-at.bofh.it>
 <65zZH-6Bw-23@gated-at.bofh.it> <66grR-2DK-27@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
>> Additionally, C++ guarantees that if an exception is thrown after 
>> spin_lock() is called, then the spin_unlock() will also be called. 
>> That's an interesting mechanism by itself.
> 
> Life gets even more interesting when you hit another exception
> inside destructor(s) being executed due to first one.
> Say, spin_unlock() discovers that lock is already unlocked
> and does "throw BUG_double_unlock".

You're not allowed to throw exceptions from inside the stack unwinding 
caused by another exception, terminate() gets called in this case. In 
most cases this isn't too hard to avoid, you just have to ensure that 
exceptions don't get thrown out of destructors. Your example isn't very 
good, why would you throw an exception in that case? The caller isn't 
going to be able to do anything useful with it since it's because of a 
coding bug, some kind of assert or BUG() would be more logical.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

