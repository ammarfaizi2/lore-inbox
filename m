Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbUKWTUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbUKWTUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUKWTSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:18:35 -0500
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:23238 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261478AbUKWTP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:15:58 -0500
Message-ID: <41A38BF1.9060207@ammasso.com>
Date: Tue, 23 Nov 2004 13:13:53 -0600
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable
 in fs/fcntl.c
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost> <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk> <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> The warning is sometimes useful, but when it comes to a construct like
> 
> 	if (a < 0 || a > X)
> 
> the fact that "a" is unsigned does not make the construct silly. First 
> off, it's (a) very readable and (b) the type of "a" may not be immediately 
> obvious if it's a user typedef, for example. 
> 
> In fact, the type of "a" might depend on the architecture, or even 
> compiler flags. Think about "char" - which may or may not be signed 
> depending on ABI and things like -funsigned-char.

If 'a' could be signed on some architectures and unsigned on others, 
then I agree that "a < 0" is not silly.  But if it's always going to be 
unsigned, then I can't see how it's not silly.

> which might warn on an architecture where "pid_t" is just sixteen bits 
> wide. Does that make the code wrong? Hell no.

Wouldn't something like "sizeof(pid_t) > 2" be a better test?  It 
certainly would be a lot easier to understand than comparing with 0xffff.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
