Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbQLLNAv>; Tue, 12 Dec 2000 08:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130836AbQLLNAl>; Tue, 12 Dec 2000 08:00:41 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4101 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130272AbQLLNAa>; Tue, 12 Dec 2000 08:00:30 -0500
Subject: Re: CPU attachent and detachment in a running Linux system
To: Heiko.Carstens@de.ibm.com
Date: Tue, 12 Dec 2000 12:32:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <C12569B3.0024DA06.00@d12mta01.de.ibm.com> from "Heiko.Carstens@de.ibm.com" at Dec 12, 2000 07:42:29 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145obO-000186-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> thanks for your input but I think it won't work this way because the value
> of smp_num_cpus needs to be increased by one right before a new cpu gets
> started. Then one can imagine the following situation at one of the cpus
> that needs to be captured:

This is fine providing the code is aware of the potential race. You capture
all the CPUs up the count by one, set the new cpu going and wait for it
to jump to being captured (even though not by an interrupt) ?

> I still wonder what you and other people think about the idea of an
> interface where the parts of the kernel with per-cpu dependencies should
> register two functions...

The other approach would be too make sure the per CPU structures allocated
which consume little memory have space already for the extra processors - eg
with the arrays of pointers etc

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
