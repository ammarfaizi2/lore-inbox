Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031226AbWKURPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031226AbWKURPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031227AbWKURPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:15:45 -0500
Received: from terminus.zytor.com ([192.83.249.54]:58846 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1031226AbWKURPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:15:44 -0500
Message-ID: <4563342B.9050500@zytor.com>
Date: Tue, 21 Nov 2006 09:15:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
CC: Simon Richter <Simon.Richter@hogyros.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: implement daemon() in the kernel
References: <4561ABB4.6090700@hogyros.de> <45624A91.3010604@zytor.com> <4562C741.800@stud.feec.vutbr.cz>
In-Reply-To: <4562C741.800@stud.feec.vutbr.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Schmidt wrote:
> H. Peter Anvin wrote:
>> Simon Richter wrote:
>>> int daemon(int nochdir, int noclose)
>>> {
>>>     if(!nochdir)
>>>         chdir("/");
>>>
>>>     if(!noclose)
>>>     {
>>>         int fd = open("/dev/null", O_RDWR);
>>>         dup2(fd, 0);
>>>         dup2(fd, 1);
>>>         dup2(fd, 2);
>>>         close(fd);
>>>     }
>>>
>>>     if(fork() > 0)
>>
>> ... that should be if (fork() == 0) ...
> 
> Are you sure? fork()==0 means we're the child, but it's the parent who 
> should exit, isn't it?
> 

Oh, right, of course.  Thinko; the lack of error handling confused me. 
I did that right in the assembly code.

	-hpa
