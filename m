Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277039AbRJQSiN>; Wed, 17 Oct 2001 14:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277038AbRJQSiE>; Wed, 17 Oct 2001 14:38:04 -0400
Received: from intranet.resilience.com ([209.245.157.33]:18594 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S277034AbRJQShu>; Wed, 17 Oct 2001 14:37:50 -0400
Message-ID: <3BCDCF1D.6030202@usa.net>
Date: Wed, 17 Oct 2001 11:34:05 -0700
From: Eric <ebrower@usa.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Q] pivot_root and initrd
In-Reply-To: <p05100300b7f2b3b94b17@[10.128.7.49]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>
 >> Works great.  I use it in my SuperRescue CD for example; you can
 >> there check out a complete, working example.
 >>
 >>   ftp://ftp.kernel.org/pub/dist/superresuce/
 >>
 >>     -hpa


hpa,

Thanks for the example.  The documentation for pivot_root must be just 
plain lousy--  I thought I'd go "by the book" with the following 
admonitions from the manpage:

   1) cd to new_root prior to calling pivot_root
   2) call pivot_root with relative new_root (.) and put_old
   3) call 'chroot' immediately after pivot and redirect stdin/out

You are simply doing the following, I assume with success:

   [ ... ]
   # Switch roots and run init
   cd /ram
   pivot_root /ram /ram/initrd
   exec /sbin/init "$@"

whereas I am doing something like the following:

   [ ... ]
   mount -o ro $ROOTDEV $NEWROOT
   cd $NEWROOT
   pivot_root . $OLDROOT

   # export for visibility to exec'ed shell
   export INITARGS="$@"
   export OLDROOT

   exec chroot . sh -c 'umount $OLDROOT; exec -a init.new /sbin/init
     $INITARGS' <dev/console >dev/console 2>&1

I am mystified that the call to 'exec /sbin/init' works if you are using 
the standard (you mention "based on RedHat7.1" util-linux") /sbin/init 
proggie, and that a standard RH7.1 initscripts would not complain when 
the root filesystem is already mounted r/w.

I would also guess that you are susceptible to the kernel's change_root 
call if your /sbin/init terminates.  I'll have to play with the disk a bit.

E

