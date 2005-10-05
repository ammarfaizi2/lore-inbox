Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbVJEPlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbVJEPlj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbVJEPlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:41:39 -0400
Received: from truxi.wincor-nixdorf.com ([217.115.67.78]:9618 "EHLO
	truxi.wincor-nixdorf.com") by vger.kernel.org with ESMTP
	id S965212AbVJEPlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:41:39 -0400
Message-ID: <4343F412.8070208@wincor-nixdorf.com>
Date: Wed, 05 Oct 2005 17:41:06 +0200
From: Peter Duellings <Peter.Duellings@wincor-nixdorf.com>
Organization: Wincor Nixdorf
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.1) Gecko/20040707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel error in system call accept() under kernel 2.6.8
References: <43301BC4.9080305@wincor-nixdorf.com> <1127230327.6276.1.camel@localhost.localdomain>
In-Reply-To: <1127230327.6276.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,


meanwhile we could generate a strace for the problem.
However, I guess that the strace does not give the desired
information (see parts below).

Additionally we added in the program the output of the return
value of the accept() system call . The return value is -512
and the errno value is 0!
Usually the return value should be -1 and the errno  should
contain the value without the sign of the error.


Any idea or comment on this ?

Thanks,


Peter Düllings

---------<strace>------------
2682  09:25:29.238663 accept(21,  <unfinished ...>
2688  09:25:29.263486 accept(33, {sa_family=AF_INET, sin_port=htons(32811),
sin_addr=inet_addr("127.0.0.1")}, [16]) = 40 <27.171270>
2688  09:25:56.589969 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
restarted) <0.385453>
2688  09:25:56.975563 --- SIGCHLD (Child exited) @ 0 (0) ---
2688  09:25:56.975676 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
restarted) <0.205963>
2688  09:25:57.181770 --- SIGCHLD (Child exited) @ 0 (0) ---
2688  09:25:57.181842 accept(33,  <unfinished ...>
2682  09:25:57.231961 <... accept resumed> {sa_family=AF_INET, 
sin_port=htons
(32882), sin_addr=inet_addr("127.0.0.1")}, [16]) = 43 <27.993066>
2682  09:25:57.234320 accept(21,  <unfinished ...>
2688  09:25:57.538314 <... accept resumed> 0x82fa7e0, [16]) = ? ERESTARTSYS
(To be restarted) <0.356435>
2688  09:25:57.538429 --- SIGCHLD (Child exited) @ 0 (0) ---
2688  09:25:57.538488 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
restarted) <0.015688>
2688  09:25:57.554315 --- SIGCHLD (Child exited) @ 0 (0) ---
2688  09:25:57.554370 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
restarted) <0.192660>
2688  09:25:57.747151 --- SIGCHLD (Child exited) @ 0 (0) ---
2688  09:25:57.747236 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
restarted) <0.097813>
....
.
---------</strace>------------



Alan Cox wrote:

> On Maw, 2005-09-20 at 16:25 +0200, Peter Duellings wrote:
> 
>>Obviously there are some cases where the accept() system call does
>>not set the errno variable if the accept() system call returns
>>with a value less than zero:
> 
> 
> Not actually possible. The kernel returns a positive value, zero or a
> negative value which is the errno code negated. It has no mechanism to
> return a negative value and not error.
> 
> What does strace show for the failing case ?
> 
> 


-- 


