Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbUL0Tsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUL0Tsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbUL0Ts3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:48:29 -0500
Received: from gateway.penguincomputing.com ([64.243.132.186]:12750 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S261961AbUL0TqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:46:20 -0500
Message-ID: <41D0668B.206@penguincomputing.com>
Date: Mon, 27 Dec 2004 11:46:19 -0800
From: Tymm Twillman <ttwillman@penguincomputing.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4, 2.6, i686/athlon and LDT's
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've some questions about LDT usage WRT threads.  I'm working currently 
with 2.4 kernels (although will be moving to 2.6 relatively soon) and 
have had a lot of difficulty finding decent resources to adequately 
explain proper LDT usage (from really why they're used to the 
complexities of actually using them). 

Context here is process freezing/restoring and how to properly 
save/restore LDT entries for a given process -- with 2.4, glibc will 
call modify_ldt() whenever the pthreads library is linked in (regardless 
of whether threads are actually used, and regardless of whether there 
are multiple threads currently running) on i686/athlon platforms to set 
up a thread-specific storage area.  (I'm not looking to save/restore all 
information for individual threads; that could get icky with multiple 
threads running). 

It appears that use of the LDT is to speed up context switching between 
threads, although I haven't even found especially good references WRT 
that.  I have looked through the info in the IA Developers publications 
and have whacked my head against Google quite a bit.  However, every bit 
of clarity I've found there has been offset by new confuzled bits.

I also have found it's possible to compile glibc not to use LDT's on 
these platforms; does anyone have comparison information w/threads using 
LDT's and without (performance, protection, etc)?

Also, 2.6 appears to have moved to a tss storage area attributed with 
each thread in the thread_struct... I'll be digging into that soon 
enough, but if anyone has quick information on comparing this to the 2.4 
tss mechanism I'd appreciate it; mainly regarding whether LDT's are 
involved and if there are any gotchas there, or if it's much simpler and 
doesn't need anything special to use.  Also if it doesn't use LDT's, 
what's the performance impact in moving away from them?

I'm not looking for information on saving/restoring processes outside 
the LDT-specific bits -- I'm set on pretty much everything else.

Thanks for your time,

-Tymm
