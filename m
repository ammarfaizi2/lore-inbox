Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268725AbUHLUOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268725AbUHLUOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268740AbUHLUOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:14:46 -0400
Received: from mail.tmr.com ([216.238.38.203]:11538 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268725AbUHLUOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:14:31 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: AES assembler optimizations
Date: Thu, 12 Aug 2004 16:18:11 -0400
Organization: TMR Associates, Inc
Message-ID: <cfgint$g8n$1@gatekeeper.tmr.com>
References: <cfb901$ctg$1@terminus.zytor.com><2riR3-7U5-3@gated-at.bofh.it> <20040810133609.4f1ca352.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092341309 16663 192.168.12.100 (12 Aug 2004 20:08:29 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040810133609.4f1ca352.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> On sparc64, we:
> 
> 1) Always save the full FPU state at context switch time if it
>    is active.
> 
> 2) On entry to a FPU-using kernel routine, we save the FPU if
>    it is active.
> 
> 3) On exit from a FPU-using kernel routine, we do nothing
>    except mark the FPU as inactive.
> 
> 4) FPU-disabled traps by the user restore the state saved
>    by #1 or #2

Depending on the cost saving of not saving the registers if they haven't 
changed, vs. the time to take the trap and set the FPU active again, it 
might be a win overall, even if you never used FPU in the kernel. Wasn't 
there a change between saving everything and saving FPU only when used 
"back when?" I seem to remember something about that, and the cost of 
the test vs. the cost of just doing the save.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
