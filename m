Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966951AbWKUJav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966951AbWKUJav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966952AbWKUJav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:30:51 -0500
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:15084 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S966951AbWKUJau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:30:50 -0500
Message-ID: <4562C741.800@stud.feec.vutbr.cz>
Date: Tue, 21 Nov 2006 10:30:41 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Simon Richter <Simon.Richter@hogyros.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: implement daemon() in the kernel
References: <4561ABB4.6090700@hogyros.de> <45624A91.3010604@zytor.com>
In-Reply-To: <45624A91.3010604@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.177 () FROM_ENDS_IN_NUMS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Simon Richter wrote:
>> int daemon(int nochdir, int noclose)
>> {
>>     if(!nochdir)
>>         chdir("/");
>>
>>     if(!noclose)
>>     {
>>         int fd = open("/dev/null", O_RDWR);
>>         dup2(fd, 0);
>>         dup2(fd, 1);
>>         dup2(fd, 2);
>>         close(fd);
>>     }
>>
>>     if(fork() > 0)
> 
> ... that should be if (fork() == 0) ...

Are you sure? fork()==0 means we're the child, but it's the parent who 
should exit, isn't it?

> 
>>         _exit(0);
> 
>     setsid();
>> }
>>

Michal
