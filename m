Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131506AbQLPHj6>; Sat, 16 Dec 2000 02:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbQLPHjs>; Sat, 16 Dec 2000 02:39:48 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:1800 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131509AbQLPHjk>;
	Sat, 16 Dec 2000 02:39:40 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB-related Oops in test12 
In-Reply-To: Your message of "Fri, 15 Dec 2000 15:37:29 BST."
             <20001215153729.C829@nightmaster.csn.tu-chemnitz.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Dec 2000 18:09:08 +1100
Message-ID: <13427.976950548@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000 15:37:29 +0100, 
Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> wrote:
>> Trace; c01091d8 <cpu_idle+38/50>
>
>> Trace; c0105000 <empty_bad_page+0/1000>
>> Trace; c0100191 <L6+0/2>
>
>Once again we have these two symbols on the stack. 

Probably spurious.  Remember that ix86 show stack prints anything that
looks like a kernel address, whether it is a real return address or
not, you can get false positives.  kdb goes to a _lot_ more work to get
a more accurate backtrace and even that sometimes goes wrong.  Always
assume that any address on an ix86 oops might be irrelevant.

In this case L6 is the return address from start_kernel.  start_kernel
ends up calling cpu_idle.  Everything above cpu_idle will be the
interrupt handler, ignore anything below cpu_idle.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
