Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSHRMI0>; Sun, 18 Aug 2002 08:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSHRMI0>; Sun, 18 Aug 2002 08:08:26 -0400
Received: from adsl-161-92.barak.net.il ([62.90.161.92]:5133 "EHLO
	hirame.qlusters.com") by vger.kernel.org with ESMTP
	id <S314446AbSHRMIZ>; Sun, 18 Aug 2002 08:08:25 -0400
Subject: Re: Alloc and lock down large amounts of memory
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <23B25974812ED411B48200D0B774071701248520@exchusa03.intense3d.com>
References: <23B25974812ED411B48200D0B774071701248520@exchusa03.intense3d.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 15:09:44 +0300
Message-Id: <1029672587.12504.88.camel@sake>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-16 at 17:38, Bhavana Nagendra wrote:
> Hi,
> 
> I have a few questions with regards to alloc'ing and locking down memory.
> An example 
> would be very useful.  Please CC me on any responses.
> 
> 1. Is there a mechanism to lock down large amounts of memory (>128M, upto
> 256M).

>From user space? kernel space? The answer is yes to both but the
mechnism is different.

>     Can 256M be allocated using vmalloc, if so is it swappable?

It can be alloacted via vmalloc and AFAIK it is not swappable by
default. This doesn't sound like a very good idea though.

> 2. Is it possible for a user process and kernel to access the same shared
> memory?

Yes. See /proc/kcore for a very obvious example. Also "Linux device
drivers second edition" has many good exmaple on the subject in the
chapter devoted to mmap.

> 3. Can a shared memory have visibility across processes, i.e. can process A
> access 
> memory that was allocated by process B?

Of course. This is the definition of shared memeory...
Just one thing to keep in mind - 'allocating' memory really doesn't do
that much as you might think. Until the memory is *accessed* for the
first time, all you got for the most part are some entries in a table
somwehere...

> 4. When a process exits will it cause a close to occur on the device?

Depends how you got the shared memeory. With mmap() it's yes (for
regular files at least), with shmget/shmat it's no by default. For mmap
of non regulat files (e.g. device files) anything the device file writer
had in mind is the answer.

man shmget, shmat, shmat and finally mmap will help you a lot.

Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
Code mangler, senior coffee drinker and VP SIGSEGV
Qlusters ltd.

"You got an EMP device in the server room? That is so cool."
      -- from a hackers-il thread on paranoia



