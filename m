Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUCEAhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 19:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUCEAhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 19:37:18 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:39825 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262103AbUCEAhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 19:37:12 -0500
Message-ID: <4047CBB3.9050608@nortelnetworks.com>
Date: Thu, 04 Mar 2004 19:37:07 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: problem with cache flush routine for G5?
References: <40479A50.9090605@nortelnetworks.com> <1078444268.5698.27.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> First of all, why do you need to flush the cache at all ?

In-house OS emulator.  For some reason it wants to be able to flush the 
cache.  I don't know why.

> If you are talking about the cache flush in the 32 bits bootloaders,
> then yes, this seem to be broken, you should ask Tom Rini who
> maintain these things.
> 
> The kernel proper definitely doesn't contain such a routine.

It did in 2.4, and we added a syscall to export it to userspace.  Now 
I'm supposed to figure out what to do for 2.6, and it appears that the 
kernel version is gone and the one in boot is screwed.


The only remaining ppc version of flush_data_cache is used by 
flush_instruction_cache in arc/ppc/boot/common/util.S

There is also another version of flush_instruction_cache implemented in 
arch/ppc/kernel/misc.S.


Here are the suspicious instances of flush_instruction_cache in 
arch/ppc/boot:

boot/prep/head.S:       bl      flush_instruction_cache
boot/common/util.S:_GLOBAL(flush_instruction_cache)
boot/simple/relocate.S: b       flush_instruction_cache
boot/simple/relocate.S: b       flush_instruction_cache
boot/simple/misc-embedded.c:    flush_instruction_cache();






-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

