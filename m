Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288882AbSAIG3W>; Wed, 9 Jan 2002 01:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288900AbSAIG3M>; Wed, 9 Jan 2002 01:29:12 -0500
Received: from smtp.comcast.net ([24.153.64.2]:52027 "EHLO mtaout45-01")
	by vger.kernel.org with ESMTP id <S288882AbSAIG3C>;
	Wed, 9 Jan 2002 01:29:02 -0500
Date: Wed, 09 Jan 2002 01:29:04 -0500
From: Brian <hiryuu@envisiongames.net>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <20020108193904.A1068@w-mikek2.beaverton.ibm.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <0GPN00CMLRC7U8@mtaout45-01.icomcast.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0201072122290.14092-100000@localhost.localdomain>
 <20020108193904.A1068@w-mikek2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can this be correct?

Intuitively, I would expect several CPUs hammering away at the compile to 
finish faster than one.  Given these numbers, I would have to conclude 
that is not just wrong, but absolutely wrong.  Compile time increases 
linearly with the number of jobs, regardless of the number of CPUs.

What would cause this?  Severe memory bottlenecks?

	-- Brian

On Tuesday 08 January 2002 10:39 pm, Mike Kravetz wrote:
> --------------------------------------------------------------------
> mkbench - Time how long it takes to compile the kernel.
>         We use 'make -j 8' and increase the number of makes run
>         in parallel.  Result is average build time in seconds.
>         Lower is better.
> --------------------------------------------------------------------
> # CPUs      # Makes         Vanilla         O(1)	haMQ
> --------------------------------------------------------------------
> 2           1                188             192        184
> 2           2                366             372        362
> 2           4                730             742        600
> 2           6               1096            1112        853
> 4           1                102             101         95
> 4           2                196             198        186
> 4           4                384             386        374
> 4           6                576             579        487
> 8           1                 58              57         58
> 8           2                109             108        105
> 8           4                209             213        186
> 8           6                309             312        280
