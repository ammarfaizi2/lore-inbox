Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262570AbTCRSmr>; Tue, 18 Mar 2003 13:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbTCRSmp>; Tue, 18 Mar 2003 13:42:45 -0500
Received: from chello212017098056.surfer.at ([212.17.98.56]:60166 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id <S262567AbTCRSmn>;
	Tue, 18 Mar 2003 13:42:43 -0500
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200303181856.h2IIu6b16953@hofr.at>
Subject: Re: bug in kernel/sysctl.c (SYSIPC) ?
In-Reply-To: <20030318104051.0fb171ed.rddunlap@osdl.org> from "Randy.Dunlap"
 at "Mar 18, 2003 10:40:51 am"
To: "Randy.Dunlap" <rddunlap@osdl.org>
Date: Tue, 18 Mar 2003 19:55:36 +0100 (CET)
CC: Der Herr Hofrat <der.herr@hofr.at>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 18 Mar 2003 08:51:17 +0100 (CET) Der Herr Hofrat <der.herr@hofr.at> wrote:
> 
> |  atleast in kernel 2.4.19 and 2.4.20 in kernel/sysctl.c shmmax and shmall use
> |  the proc_dointvec_minmax callback without passing a min/max value - is there
> |  a reson for this or is this a simple bug ?
> | 
> | linux/kenrel/sysctl.c (line 221 for 2.4.19/20)
> | 
> | #ifdef CONFIG_SYSVIPC
> | 	{KERN_SHMMAX, "shmmax", &shm_ctlmax, sizeof (size_t),
> | 	 0644, NULL, &proc_doulongvec_minmax},
> | 	{KERN_SHMALL, "shmall", &shm_ctlall, sizeof (size_t),
> | 	 0644, NULL, &proc_doulongvec_minmax},
> | 	...
> | #endif
> 
> The min and max values default to 0 if not specified (initialized),
> and the _minmax functions have code to handle those cases.
> 
> so as long as the intended min/max values were 0, I don't see a
> problem.  Are you seeing a problem?
>

not directly a problem - my assumption was that shmmax would be bounded in some
way - currently you can write any value into /proc/sys/kernel/shmmax - and I
don't think that the inteded behavior of this is to permit any value - or if 
it is - what is the point of using the _minimax and not simple proc_doulongvec ?

hofrat 
