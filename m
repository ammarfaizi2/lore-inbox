Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbTFQG1o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 02:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264612AbTFQG1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 02:27:43 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:51973 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264610AbTFQG1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 02:27:42 -0400
Message-ID: <3EEEBB1F.70609@digital.com>
Date: Tue, 17 Jun 2003 12:24:23 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: "David S. Miller" <davem@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, davidm@hpl.hp.com,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: force_successful_syscall_return() buggy?
References: <fa.it5uct2.s4s8om@ifi.uio.no> <fa.gvpfoqi.ngk8p2@ifi.uio.no>
In-Reply-To: <fa.gvpfoqi.ngk8p2@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Mon, 2003-06-16 at 10:55, Russell King wrote:
> 
>>I'm not actually talking about subsequent syscalls issued by the kernel.
>>I'm talking about stuff like init, bash, and the module tools.
> 
> 
> Wrong, after the go for the first time into user space, the
> next trap into the kernel will put the pt_regs at the top at
> the stack where we expect it to be.
> 

I was facing a simillar problem with ptrace on Alpha (ptrace on alpha 
expect the pt_regs at current + 2*PAGE_SIZE for 2.4. kernel  ) w.r.t 
www.openssi.org project. What i found was that  even after we return to 
user space subsequent syscalls are not putting pt_regs at that offset. I 
guess while entering the kernel kernel stack pointer always point to 
value stored in thread_struct.ksp ?

-aneesh


