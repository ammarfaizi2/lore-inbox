Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265920AbUHPV1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUHPV1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 17:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUHPV1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 17:27:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:41413 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265920AbUHPV1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 17:27:33 -0400
Date: Mon, 16 Aug 2004 14:26:37 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: opacki@acn.waw.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: LKM, problem with simple char from string.
Message-Id: <20040816142637.69105e2c.rddunlap@osdl.org>
In-Reply-To: <200408161231.51998.opacki@acn.waw.pl>
References: <200408161231.51998.opacki@acn.waw.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 12:31:51 +0200 authn wrote:

| Hello,
| I am coding a linux kernel module and have problem with some string from user 
| space (from execve system call). There is no problem with useing this string 
| as a one, for example printk(KERN_ALERT "%s", string) works fine. 
| Problem appears when i want to printk or compare single char, in first case it 
| is printked with some extra '<1>' and in second case, when i compare it with 
| other one, it doesnt fit to real char (it is "connected" with '<1>' in some 
| way ?). I tried to copy it to kmalloced buffer:
| 
| if ((k_space=(char *)kmalloc(len, GFP_KERNEL))==NULL)
|                         return -1;
| memcpy_fromfs((void *)k_space, (void *)argv[argc], len); 
| 
| but then playing with k_space[i] was the same. 
| Short code from module:
|                 if ((k_space=(char *)kmalloc(len, GFP_KERNEL))==NULL)
|                         return -1;
|                 memset(k_space, '\0', sizeof(k_space));

I don't think that this is the main problem, but sizeof(k_space) here
is just the sizeof a pointer (I guess, can't see entire source code),
like 4 or 8.

|                 memcpy_fromfs((char *)k_space, (char *)argv[argc], len);
|                 printk(KERN_ALERT"%s\n", k_space);
|                 printk(KERN_ALERT "%c\n",k_space[i]);
| And then i ll have in log file string (from first printk call) and char with 
| <1> (from second printk call). It doesnt let me to compare chars.
| What it happens ?


--
~Randy
