Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSCYP0c>; Mon, 25 Mar 2002 10:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310660AbSCYP0M>; Mon, 25 Mar 2002 10:26:12 -0500
Received: from wet.kiss.uni-lj.si ([193.2.98.10]:1547 "EHLO wet.kiss.uni-lj.si")
	by vger.kernel.org with ESMTP id <S293680AbSCYP0H>;
	Mon, 25 Mar 2002 10:26:07 -0500
Content-Type: text/plain;
  charset="iso-8859-2"
From: Rok =?iso-8859-2?q?Pape=BE?= <rok.papez@lugos.si>
Reply-To: rok.papez@lugos.si
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
Date: Mon, 25 Mar 2002 16:09:05 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <E16pE0U-00073m-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <02032516090500.02095@strader.home>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan and Paul.

On Sunday 24 March 2002 20:50, Alan Cox wrote:

> > How does a process react that doesn't get no more memory?
>
> Thats up to the process. If a program doesn't handle malloc/mmap/etc
> failures then its junk anyway

Agreed 101%.

On Sunday 24 March 2002 21:43, Paul P Komkoff Jr wrote:
> Replying to Alan Cox:
> > Thats up to the process. If a program doesn't handle malloc/mmap/etc
> > failures then its junk anyway
>
> The recent junk I fighting with to take full advantage of overcommit
> accounting is squid.
> Very popular junk. Maybe rsync uses same 'secret technique' to handle
> malloc failures? :)))
>
> Btw. Overcommit handling not very good yet.
> Squid hits the limit, then bails out. Then shell script trying to start new
> instance of squid (actually trying to sleep before restart), but gets
> 'fork - cannot allocate memory'. seems that memory isn't dealloced
> from already exited process space :(

In all the code I've written I always check if malloc() and friends don't 
succeed. In some instances the code can even handle this gracefully and 
malloc failure doesn't cause a fatal application error.

Now if kernel kills my process it doesn't matter if I can handle the out of 
memory condition or not. The kernel already made a decision for me instead of 
my application... and never mind the data I have cached in applications 
buffers... the kernel also decided it wasn't worth writing to a disk.

--------------------------------------------------------------------------

Alan.. I would find it acceptable if a process is killed if it tries to 
malloc() memory *after* a previous malloc has already failed and there is 
still out-of-memory condition.

-- 
best regards,
Rok Pape¾.
