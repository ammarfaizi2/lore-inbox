Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbVJERxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbVJERxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbVJERxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:53:51 -0400
Received: from ns.firmix.at ([62.141.48.66]:50844 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1030303AbVJERxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:53:51 -0400
Subject: Re: kernel error in system call accept() under kernel 2.6.8
From: Bernd Petrovitsch <bernd@firmix.at>
To: Peter Duellings <Peter.Duellings@wincor-nixdorf.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <4343F412.8070208@wincor-nixdorf.com>
References: <43301BC4.9080305@wincor-nixdorf.com>
	 <1127230327.6276.1.camel@localhost.localdomain>
	 <4343F412.8070208@wincor-nixdorf.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 05 Oct 2005 19:53:48 +0200
Message-Id: <1128534828.16804.91.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 17:41 +0200, Peter Duellings wrote:
[....]
> meanwhile we could generate a strace for the problem.
> However, I guess that the strace does not give the desired
> information (see parts below).

Yup. Where exactly does the kernel return -512 in the strace output?
I can see only 40 and 43 which are valid file descriptors.

> Additionally we added in the program the output of the return
> value of the accept() system call . The return value is -512
> and the errno value is 0!
>
> Usually the return value should be -1 and the errno  should
> contain the value without the sign of the error.
> 
> 
> Any idea or comment on this ?

You are doing somewhere else something wrong so post a minimalistic
piece of source code of how you get to it.
Or show the *failing* case in the strace output.

> Thanks,

[...]
> ---------<strace>------------
> 2682  09:25:29.238663 accept(21,  <unfinished ...>
> 2688  09:25:29.263486 accept(33, {sa_family=AF_INET, sin_port=htons(32811),
> sin_addr=inet_addr("127.0.0.1")}, [16]) = 40 <27.171270>
> 2688  09:25:56.589969 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
> restarted) <0.385453>
> 2688  09:25:56.975563 --- SIGCHLD (Child exited) @ 0 (0) ---
> 2688  09:25:56.975676 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
> restarted) <0.205963>
> 2688  09:25:57.181770 --- SIGCHLD (Child exited) @ 0 (0) ---
> 2688  09:25:57.181842 accept(33,  <unfinished ...>
> 2682  09:25:57.231961 <... accept resumed> {sa_family=AF_INET, 
> sin_port=htons
> (32882), sin_addr=inet_addr("127.0.0.1")}, [16]) = 43 <27.993066>
> 2682  09:25:57.234320 accept(21,  <unfinished ...>
> 2688  09:25:57.538314 <... accept resumed> 0x82fa7e0, [16]) = ? ERESTARTSYS
> (To be restarted) <0.356435>
> 2688  09:25:57.538429 --- SIGCHLD (Child exited) @ 0 (0) ---
> 2688  09:25:57.538488 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
> restarted) <0.015688>
> 2688  09:25:57.554315 --- SIGCHLD (Child exited) @ 0 (0) ---
> 2688  09:25:57.554370 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
> restarted) <0.192660>
> 2688  09:25:57.747151 --- SIGCHLD (Child exited) @ 0 (0) ---
> 2688  09:25:57.747236 accept(33, 0x82fa7e0, [16]) = ? ERESTARTSYS (To be
> restarted) <0.097813>
> ....
> .
> ---------</strace>------------
[...]

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

