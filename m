Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVLCCrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVLCCrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVLCCrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:47:18 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:33508 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751172AbVLCCrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:47:17 -0500
Date: Fri, 02 Dec 2005 20:47:13 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: copy_from_user/copy_to_user question
In-reply-to: <5fvam-3vP-9@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43910731.4090404@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5fv0G-3kS-11@gated-at.bofh.it> <5fvam-3vP-9@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vinay Venkataraghavan wrote:
> But this is not always the case right. The point that
> you mention above is specifically why I posted this
> question. It could well be the case that the   user
> space page could be swapped out when the user space
> process is blocked. So when the ioctl is serviced in
> kernel space, there is no guarantee that the page is
> still mapped. This could cause a page fault. 
> I think this is why we need to do a
> copy_to_user/copy_from_user.

I don't think this is actually the case. I'm not entirely sure, but I 
believe that if memcpy from user space works at all on a platform, then 
if the page is swapped out it will still get swapped in when needed. In 
any case, this is not the main reason for using these functions. The 
main reason is that memory addresses passed from userspace might not be 
valid at all, and reading these addresses directly would cause a kernel 
oops in that case. These functions set up an exception handler so that 
invalid address reads/writes return failure instead of crashing the system.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

