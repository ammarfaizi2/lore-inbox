Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293249AbSC3XX7>; Sat, 30 Mar 2002 18:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293276AbSC3XXj>; Sat, 30 Mar 2002 18:23:39 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:25092 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293249AbSC3XXh>;
	Sat, 30 Mar 2002 18:23:37 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] block/IDE/interrupt lockup 
In-Reply-To: Your message of "Sat, 30 Mar 2002 11:06:25 PST."
             <3CA60CB1.E33080D5@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 31 Mar 2002 09:23:23 +1000
Message-ID: <11003.1017530603@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2002 11:06:25 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>What I'd like is a debugging function `can_sleep()'.  This
>is good for documentary purposes, and will catch bugs.
>
>So kmalloc() would gain:
>
>	if (gfp_flags & __GFP_WAIT)
>		can_sleep();

can_sleep_if(gfp_flags & __GFP_WAIT) would be better.  can_sleep_if()
is 
  do { } while(0)
for no debugging, for debugging it is
  if (unlikely(condition)) {
  	whine(__stringify(condition))
  }

One line instead of two, no references to variables when debugging is
off, automatically adds unlikely.

