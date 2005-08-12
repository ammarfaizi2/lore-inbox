Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVHLSRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVHLSRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVHLSQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:16:54 -0400
Received: from web80214.mail.yahoo.com ([66.218.79.49]:9642 "HELO
	web80214.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750808AbVHLSQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:16:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VfzK4sWf3G+NX5ett3YFyPq+8ZiEec27I3jFjwZ1aUTE7BpK/oFxAWHJrWDn2m2nsL/I7vShMhhwJm35rLtcn8DMsPiu/n+WqTnN7LHK4kIBbsWI2NDXyKMrvrMN2C6AdrumGIfowiCgPFTxhEZEDc+g7ubz2GayRJFYCMgP4Zc=  ;
Message-ID: <20050812181623.6814.qmail@web80214.mail.yahoo.com>
Date: Fri, 12 Aug 2005 11:16:23 -0700 (PDT)
From: KrnlUsr <kdp102@yahoo.com>
Subject: copy_from_user, copy_to_user in kernel
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Why does copy_from/to_user routines fail if both
source and destination are in kernel space. I have a
kernel module that:

1. takes some parameters from user space via ioctl
(kernel copies arguments with copy_from_user)

2. processes command(s) from user and 

3. returns output to user with copy_to_user

now i have a kernel thread that wants to talk to same 
kernel module. basically user space programs will talk
to my kernel module with ioctl but kernel threads will
call EXPORTed routines. i'll have another set of
routines to work with these two interfaces. but can i 
have the core routines copy processed data back to
kernel thread or user space with copy_to_user. or do i
have to have some check saying if called from ioctl
call copy_to_user otherwise call memcpy?


                       user space interface
                                  ^
                   ---------------|---------------
                                  V
     kernel      <-->         kernel module
     thread


thanks

