Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277910AbRJNXdc>; Sun, 14 Oct 2001 19:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277911AbRJNXdW>; Sun, 14 Oct 2001 19:33:22 -0400
Received: from serval.noc.ucla.edu ([169.232.10.12]:27300 "EHLO
	serval.noc.ucla.edu") by vger.kernel.org with ESMTP
	id <S277910AbRJNXdL>; Sun, 14 Oct 2001 19:33:11 -0400
Message-ID: <3BCA2015.5080306@ucla.edu>
Date: Sun, 14 Oct 2001 16:30:29 -0700
From: Benjamin Redelings I <bredelin@ucla.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010911
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: VM question: side effect of not scanning Active pages?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	In both Andrea and Rik's VM, I have tried modifying try_to_swap_out so
that a page would be skipped if it is "active".  For example, I have
currently modified 2.4.13-pre2 by adding:

          if (PageActive(page))
                  return 0;

after testing the hardware referenced bit.  This was motivated by
sections of VM-improvement patches written by both Rik and Andrea.
	This SEEMS to increase performance, but it has another side effect.  The
RSS of unused daemons no longer EVER drops to 4k, which it does without
this modification.  The RSS does decrease (usually) to the value of
shared memory, but the amount of shared memory only gets down to about
200-300k instead of decreasing to 4k.
	Can anyone tell me why not scanning Active page for swapout would have
this effect?  Thanks!

-BenRI
-- 
"I will begin again" - U2, 'New Year's Day'
Benjamin Redelings I      <><     http://www.bol.ucla.edu/~bredelin/


