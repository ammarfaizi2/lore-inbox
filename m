Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbUCHF66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 00:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbUCHF66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 00:58:58 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:64714 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262399AbUCHF65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 00:58:57 -0500
Message-ID: <404C0B57.6030607@BitWagon.com>
Date: Sun, 07 Mar 2004 21:57:43 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Potential bug in fs/binfmt_elf.c?
References: <1078508281.3065.33.camel@linux.littlegreen>	<404A1C71.3010507@redhat.com>	<1078607410.10313.7.camel@linux.littlegreen> <m1brn8us96.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1brn8us96.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  LOAD           0x001000 0x00400000 0x00400000 0x00000 0x10000000 R   0x1000
> 
> 
> What is the purpose of allocating 256MB of read-only zeros?

To prevent the kernel from placing any shared libraries there [via mmap()
from ld-linux.so.2], especially under the influence of exec-shield.
This is 'wine', which wants to reserve that address space for mapping
executables that were built for some other operating system.  For this
purpose, the .p_flags of PF_R instead could be 0 [==> PROT_NONE]; but
do_brk() still turns either one into 'prw.' which has potential memory
[over-]commit charges.  The expected 'pr--' [or 'p---'] should have
a memory commit cost of zero.

-- 

