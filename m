Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTBOPyP>; Sat, 15 Feb 2003 10:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbTBOPyP>; Sat, 15 Feb 2003 10:54:15 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:22704 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S262806AbTBOPyN>; Sat, 15 Feb 2003 10:54:13 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200302151604.RAA02344@faui11.informatik.uni-erlangen.de>
Subject: Re: [PATCH][2.5][8/14] smp_call_function_on_cpu - s390
To: zwane@holomorphy.com (Zwane Mwaikambo)
Date: Sat, 15 Feb 2003 17:04:04 +0100 (MET)
Cc: weigand@immd1.informatik.uni-erlangen.de (Ulrich Weigand),
       linux-kernel@vger.kernel.org (Linux Kernel),
       schwidefsky@de.ibm.com (Martin Schwidefsky)
In-Reply-To: <Pine.LNX.4.50.0302151036420.16012-100000@montezuma.mastecende.com> from "Zwane Mwaikambo" at Feb 15, 2003 10:38:03 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> On Sat, 15 Feb 2003, Ulrich Weigand wrote:
> > That's still '&&' instead of '&'.
> 
> *sigh*

Hmm.  I think this code still has a problem.  If the caller
passes in a mask containing bits for offline CPUs, those will
be counted here

> +	num_cpus = hweight32(mask);

but there will be no external interrupt generated for those,
and thus this loop

> +	while (atomic_read(&data.started) != num_cpus)

will never terminate ...


Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
