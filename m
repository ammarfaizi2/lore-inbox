Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277526AbRJOMlg>; Mon, 15 Oct 2001 08:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277527AbRJOMl1>; Mon, 15 Oct 2001 08:41:27 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:5900 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S277526AbRJOMlP>;
	Mon, 15 Oct 2001 08:41:15 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100300b7f08800c756@[192.168.239.101]>
In-Reply-To: <3BCA2015.5080306@ucla.edu>
In-Reply-To: <3BCA2015.5080306@ucla.edu>
Date: Mon, 15 Oct 2001 13:38:22 +0100
To: Benjamin Redelings I <bredelin@ucla.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: VM question: side effect of not scanning Active pages?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	In both Andrea and Rik's VM, I have tried modifying try_to_swap_out so
>that a page would be skipped if it is "active".  For example, I have
>currently modified 2.4.13-pre2 by adding:
>
>          if (PageActive(page))
>                  return 0;
>
>after testing the hardware referenced bit.  This was motivated by
>sections of VM-improvement patches written by both Rik and Andrea.
>	This SEEMS to increase performance, but it has another side 
>effect.  The
>RSS of unused daemons no longer EVER drops to 4k, which it does without
>this modification.  The RSS does decrease (usually) to the value of
>shared memory, but the amount of shared memory only gets down to about
>200-300k instead of decreasing to 4k.
>	Can anyone tell me why not scanning Active page for swapout would have
>this effect?  Thanks!

The "active" pages in your inactive daemons are probably the glibc 
pages, which are generally in use by other applications.  It should 
not have any real effect on the system - in fact, keeping glibc in 
memory is probably a Good Thing, and may be partially responsible for 
your improvement in performance.

AFAICT, 'pinning' active pages in memory is a good thing, provided 
they are deactivated appropriately after a period of disuse.  This 
appears to be the case in current kernels and the new VM, so you're 
good to go in my view.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
