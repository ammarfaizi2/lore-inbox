Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132719AbRDDAbW>; Tue, 3 Apr 2001 20:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132724AbRDDAbM>; Tue, 3 Apr 2001 20:31:12 -0400
Received: from chromium11.wia.com ([207.66.214.139]:63249 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S132719AbRDDAbG>; Tue, 3 Apr 2001 20:31:06 -0400
Message-ID: <3ACA6BF4.9A3F93A2@chromium.com>
Date: Tue, 03 Apr 2001 17:33:57 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: a quest for a better scheduler
In-Reply-To: <E14kPy7-0007xx-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

for the "normal case" performance see my other message.

I agree that a better threading model would surely help in a web server, but to
me this is not an excuse to live up with a broken scheduler.

The X15 server I'm working on now is a sort of user-space TUX, it uses only 8
threads per CPU and it achieves the same level of performance of the kernel
space TUX. Even in this case the performance advantage of the multiqueue
scheduler is remarkable, especially on a multi-CPU (> 2) architecture.

To achieve some decent disk/CPU/network overlapping with the current linux
blocking disk IO limitations there is no way to avoid a "bunch of server
threads". I've (experimentally) figured out that 8-16 threads per CPU can
assure some reasonable overlapping, depending on the memory size and disk
subsystem speed. On a 8-way machine this means 64-128 active tasks, a total
disaster with the current scheduler.

Unless we want to maintain the position tha the only way to achieve good
performance is to embed server applications in the kernel, some minimal help
should be provided to goodwilling user applications :)

TIA, ciao,

 - Fabio

Alan Cox wrote:

> > Is there any special reason why any of those patches didn't make it to
> > the mainstream kernel code?
>
> All of them are worse for the normal case. Also 1500 running apache's isnt
> a remotely useful situation, you are thrashing the cache even if you are now
> not thrashing the scheduler. Use an httpd designed for that situation. Then
> you can also downgrade to a cheap pentium class box for the task ;)

