Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVBWX4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVBWX4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVBWX4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:56:39 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:53423 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261692AbVBWXqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:46:38 -0500
Date: Wed, 23 Feb 2005 17:45:15 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: msgsnd in module
In-reply-to: <3AVR2-2UO-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <421D158B.1080008@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3AVR2-2UO-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vijayalakshmi Hadimani wrote:
> Hi,
>    I am inserting a module(device driver) using insmod. 
> I want to send a message from this module to an user process.
> For this I used msgsnd with buffer in the call as a local 
> variable.  I am getting an error "EFAULT" for this call. 
> However this did not happen when I made the driver code as a
> part of kernel and not as a module.  Any idea about what could
> be the problem and how to solve it?

Well, first off, sending SysV messages from the kernel is a pretty 
bizarre thing to do. Secondly, you can't just call the system call from 
inside the kernel and pass in kernel memory, because the system call 
expects to deal with user-space memory. You'd have to duplicate some or 
all of the code of msgsnd and change it to just read the memory directly 
  instead of using copy_from_user, etc.
