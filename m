Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281966AbRLOImx>; Sat, 15 Dec 2001 03:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282046AbRLOImm>; Sat, 15 Dec 2001 03:42:42 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:60175 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281966AbRLOImY>;
	Sat, 15 Dec 2001 03:42:24 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Russ Weight <rweight@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        LSE Tech <lse-tech@lists.sourceforge.net>
Subject: Re: Static/Global Arrays 
In-Reply-To: Your message of "Fri, 14 Dec 2001 16:31:10 -0800."
             <20011214163110.A2423@us.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 15 Dec 2001 19:42:10 +1100
Message-ID: <20332.1008405730@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2001 16:31:10 -0800, 
Russ Weight <rweight@us.ibm.com> wrote:
>	I have tabulated lists of static and global arrays in the
>2.4.16 kernel. I am posting the information here in case it may be
>of interest to some of you. I would recommend starting with the 
>linux/kernel and linux/fs tables, as these are the most complete.
>
>	http://lse.sourceforge.net/resource/#staticarray

Stating the obvious: For any array with dimension [32] or [64], check
if the source code uses [NR_CPUS].  IMHO there is no point in trying to
make those arrays dynamic in size, you penalize the 99% of small
machines on the off chance that somebody is going to run single system
image Linux on a box with > 32/64 processors.  People using such large
machines can recompile the kernel with a new value of NR_CPUS.

As a separate problem, there are still places in the kernel which
assume the number of cpus can be represented in a bitmap of type long.
That code would be worth tracking down and changing to remove the
assumption that NR_CPUS <= 8*sizeof(long).  Until that is done, you
cannot run SSI Linux on machines with > 32/64 processors.

Note to self: after the bitmap code limit has been removed, make
NR_CPUS a config option to get ready for huge machines, make
CONFIG_NR_CPUS a critical config option.

