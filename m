Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWA3OwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWA3OwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 09:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWA3OwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 09:52:14 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:46454 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932296AbWA3OwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 09:52:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Pz3yopxHRcw+eRXY8024A0ebVki2Q6D+iWg1Lvvx13mJLzru8e9sFTIb0KJkUUdIzQBF7c3rqKN42jwBZIWSmGgD5WPt+iGGnzOquUFwzgsHxbO2kJyP0Mzk0AZe+I8qhHl1Vt7yJyGd5QLS/TSUDUH4KB0I5fQVS9iFPf9jtKc=
Message-ID: <43DE2814.9080504@gmail.com>
Date: Mon, 30 Jan 2006 23:52:04 +0900
From: Tejun <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jerome lacoste <jerome.lacoste@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] make it easy to test new kernels
References: <5a2cf1f60601251430k5823e7dald12c9b5f8bc297be@mail.gmail.com>
In-Reply-To: <5a2cf1f60601251430k5823e7dald12c9b5f8bc297be@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste wrote:
> 
> But maybe I am focusing on the wrong approach?
> Linux developers, what would be the thing that takes no more than 4-5
> min per day that people like me could do with our machines to help you
> improve Linux?
> 

Hello, Jerome.

As you've noted earlier in the message, swsusp will be helpful, I think. 
  Here's my suggestion.

1. setup swsusp/swsusp2 on target machines (swsusp2 works pretty well)
2. setup small (10G maybe) test partition on target machines with 
minimal distribution (just install on one machine and copy the partition 
over)
3. setup netboot for target machines (reserve one machine for kernel 
serving)

When a new kernel comes out...

1. build the kernel and set it up for netbooting
2. software suspend testing machines & reboot'em with the new kernel
    using netbooting
3. see whether things work
4. reboot and resume production system

The suspend/resume instead of full rebooting should save a lot of time. 
  If you also use netbooting for the production kernel, you can just 
change settings on the kernel serving machine to select which kernel to 
boot and which partition to mount for root fs.

-- 
tejun
