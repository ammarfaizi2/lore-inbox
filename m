Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266791AbRGFSpy>; Fri, 6 Jul 2001 14:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266790AbRGFSpf>; Fri, 6 Jul 2001 14:45:35 -0400
Received: from mysql.sashanet.com ([209.181.82.108]:12970 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S266791AbRGFSpW>; Fri, 6 Jul 2001 14:45:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: Mike Kravetz <mkravetz@sequent.com>
Subject: Re: Strange thread behaviour on 8-way x86 machine
Date: Fri, 6 Jul 2001 12:45:20 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0107031225120K.18621@mysql> <20010703115139.B1128@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20010703115139.B1128@w-mikek2.des.beaverton.ibm.com>
MIME-Version: 1.0
Message-Id: <0107061245200U.17811@mysql>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 July 2001 12:51, Mike Kravetz wrote:
> On Tue, Jul 03, 2001 at 12:25:12PM -0600, Sasha Pachev wrote:
> > Hi,
> > 
> > I have observed a rather strange behaviour doing a multi-threaded CPU 
> > benchmark on an 8-way machine running 2.4.2 SMP kernel. Even when the 
> > priority is reniced to the highest possible value, I am still unable to 
reach 
> > more than 50% CPU utilization. My benchmark just creates a bunch of 
threads 
> > with pthread_create(), and then runs a simple integer computation in each 
> > thread. On a dual with 2.4.3 kernel, and a 4-way with 2.4.2 kernel, I am 
able 
> > to reach full CPU utilization. 
> 
> I haven't had any problem fully utilizing 8 CPUs on 2.4.* kernels.  This
> may seem obvious, but do you have more than 4 CPUs worth of work for the
> system to do?  What is the runqueue length during this benchmark?

Upon further investigation and testing, it turned out that the kernel was not 
at fault - the problem was high mutex contention, which caused frequent 
context switches, and the idle CPU was apparently from the scheduler waiting 
for the original CPU to become available too often.

On a side note, it would be nice if a process could communicate to the kernel 
that it would rather run on the first available CPU than wait for the perfect 
one to become available.

-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
