Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275561AbTHNVcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 17:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275563AbTHNVcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 17:32:16 -0400
Received: from fmr03.intel.com ([143.183.121.5]:49148 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S275561AbTHNVcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 17:32:13 -0400
Message-ID: <3F3BFF49.8090909@intel.com>
Date: Fri, 15 Aug 2003 00:29:45 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel threads resource leakage
References: <Pine.LNX.4.53.0308141626440.11823@chaos>
In-Reply-To: <Pine.LNX.4.53.0308141626440.11823@chaos>
X-Enigmail-Version: 0.76.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

I forgot to mention that I use gcc 3.3; it _do_ compile the code I 
submitted since it support declarations after statements.
I did actually run tests with the code included in my posting.

About Makefile, it made this way to ensure you use the same flags as for 
kernel. It is kind of style that proposed in 2.6 kernel, adopted for 2.4.

All,

I am sorry for submitting problem before doing complete analysis. It 
reveals that I used to have improperly compiled kernel. I tried on 
another host (2.4.20 with kdb patch, have no plain 2.4.20 handy right 
now), and it works fine without resource leakage.

Regarding need to create lots of kernel threads. Of course, it is 
useless to do it very often, but consider, for example, wireless network 
card, that need to create kernel thread to manage BSS  MAC.  I would not 
get too deeply into details, but it may be situation when you need to 
create new kernel thread, for example, each laptop suspend-resume cycle.

Sure, thousands of cycles may seems too much, but it is a good way to 
check that you have no leakage. For example, in my driver testing, I do 
thousands of insmod/rmmod cycles and stuff like this. This helps to find 
bugs like 100 bytes leakage per 'insmod'.

Anyway, original example is the right way to create and terminate thread 
and may be used as example.

Sorry again for misleading posting.

Vladimir.

Richard B. Johnson wrote:

>I am using a 2.4.20 kernel. I tried your program.
>First, it didn't compile. So I would guess that you
>never tested your test program. I fixed it and I
>made a more readily useful Makefile, etc., so others
>can try it, too. It is attached.
>
>It works. It doesn't eat any resources. I guess that
>the stuff that actually does 'work' in your actual
>driver module is what is consuming resources.
>
>Although making and deleting a number of kernel threads
>is an interesting exercise, I sure hope that you don't
>really do this in a real application. It is very expensive
>to do this. If you need a kernel thread, you should have
>one (or several) that do the work and never exit.
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
>            Note 96.31% of all statistics are fiction.
>  
>


