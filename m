Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTLOQIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 11:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTLOQIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 11:08:18 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:36584 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263811AbTLOQIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 11:08:17 -0500
Message-ID: <3FDDDC68.80209@backtobasicsmgmt.com>
Date: Mon, 15 Dec 2003 09:08:08 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
CC: Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca> <3FDDD8C6.3080804@intel.com>
In-Reply-To: <3FDDD8C6.3080804@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev wrote:

> To illustrate zero cost, I did the following test:
> [tmp]$ cat t.c; gcc -S t.c; cat t.s
> static int a1=0;
> static int a2;
> /* EOF */
> 
>    .file    "t.c"
>    .local    a1
>    .comm    a1,4,4
>    .local    a2
>    .comm    a2,4,4
>    .section    .note.GNU-stack,"",@progbits
>    .ident    "GCC: (GNU) 3.3.1 20030811 (Red Hat Linux 3.3.1-1)"
> 
> As you can see, assembly code is identical, compiler did this trivial 
> optimization for me.

You've missed the point, though. Initializing a static variable to zero 
causes space to be consumed in the resulting object file (not 
instruction code to be generated). This is wasted space, because if you 
don't initialize to zero the variable will be allocated out of space 
that is _automatically_ zeroed for you. This reduces the size of the 
kernel image by not filling it with unnecessary zeroes.

