Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAIE5B>; Mon, 8 Jan 2001 23:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbRAIE4w>; Mon, 8 Jan 2001 23:56:52 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:24846 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S129267AbRAIE4i>;
	Mon, 8 Jan 2001 23:56:38 -0500
Date: Tue, 9 Jan 2001 05:56:34 +0100
From: Marc Lehmann <pcg@goof.com>
To: linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010109055633.B3297@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010108225451.A968@stefan.sime.com> <Pine.LNX.4.31.0101081501560.10554-100000@q.dyndns.org> <20010108203722.B10936@animx.eu.org> <20010109025515.S27646@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010109025515.S27646@athlon.random>; from andrea@suse.de on Tue, Jan 09, 2001 at 02:55:15AM +0100
X-Operating-System: Linux version 2.2.18 (root@cerebro) (gcc version pgcc-2.95.2.1 20001224 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 02:55:15AM +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> > [wakko@<removed>:/home/wakko/test] rmdir "`pwd`"
> > rmdir: /home/wakko/test: Invalid argument
> 
> Some other OS with a yet different retval? :)

It can be much worse (irix-6.5.4):

   bash# mkdir x; cd x; rmdir "`pwd`"
   /x: Can't remove current directory or ..

Here the error message makes sense - but is totally wron in this case :(

And here is linux-2.2.18:

   cerebro:~# mkdir x; cd x;rmdir "`pwd`"
   cerebro:~/x# ls -la
   total 6
   drwxr-x---   0 root     root           35 Jan  9 05:54 .
   drwx------  69 root     root         5372 Jan  9 05:54 ..
   cerebro:~/x# cd
   cerebro:~# ls -la x
   ls: x: No such file or directory

So, no, linux certainly does NOT remove "." ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
