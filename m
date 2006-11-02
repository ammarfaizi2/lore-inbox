Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752207AbWKBMei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbWKBMei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 07:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbWKBMei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 07:34:38 -0500
Received: from picton.eecg.toronto.edu ([128.100.10.141]:58311 "EHLO
	picton.eecg.toronto.edu") by vger.kernel.org with ESMTP
	id S1752207AbWKBMeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 07:34:37 -0500
Date: Thu, 2 Nov 2006 07:34:36 -0500
From: Livio Soares <livio@eecg.toronto.edu>
To: FENG ZHOU <zhfeng.osprey@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to optimize system time for such case?
Message-ID: <20061102123436.GA6440@eecg.toronto.edu>
Mail-Followup-To: Livio Soares <livio@eecg.toronto.edu>,
	FENG ZHOU <zhfeng.osprey@gmail.com>, linux-kernel@vger.kernel.org
References: <b3c691930611020047p4a59206aj3fc3060e2f74e426@mail.gmail.com> <b3c691930611020052k4cee7582lf58942c1b1151916@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c691930611020052k4cee7582lf58942c1b1151916@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Feng,

FENG ZHOU writes:
> Hello, all
> I am optimizing a compiler and I believe there is a bug in such
> compile. Currently, I have a test case, which is a scientific
> application, has a lot of system time. This is weird, because this
> case does not have many system calls. Meanwhile, compiled at another
> option, I found all the "system time" are gone! So, I assume there is
> some problem in the first one (though both binary produce correct
> result). I used some performance tuning tool and found the hottest
> address for CPU privilege level change event is: 0xa000000100001a70.
> This address is not in code or data segment. Now, I am kinda stuck
> here. My question is: how to find what this address is? Or find out
> what is the cause of the "system time"? Thanks in advance.
>
> PS: the platform is Itanium 2.

  This address is from inside the kernel.  On the Itanium arch, kernel starts at
0xa000000100000000

  So you  want the to  see what  function in your  kernel is at  address 0x1a70.
Looking at arch/ia64/kernel/ivt.S, it could either be an "Instruction Key Miss",
which starts  at address  0x1800, but  I'm not sure  that function  reaches your
address. Also, the "page_fault" code is  right below the ikey_miss code, so that
could be  a culprit. To make sure,  please get your kernel  binary (vmlinux) and
disassemble it with objdump. Check in which function the 0x1a70 address lies.

  If  it's a  "Instruction Key  Miss",  your compiler  is _probably_  generating
instructions  incorrectly. If  it's page-faults,  well, data  is  being accessed
differently. 

  Also, Oprofile is a tool that is worth learning how to use:
http://oprofile.sf.net/

  good luck,

		Livio


