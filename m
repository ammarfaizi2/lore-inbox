Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTETK1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 06:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTETK1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 06:27:05 -0400
Received: from pop.gmx.net ([213.165.65.60]:58437 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263676AbTETK1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 06:27:03 -0400
Message-ID: <3ECA05FA.6090008@gmx.net>
Date: Tue, 20 May 2003 12:39:54 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: alexander.riesen@synopsys.COM
CC: mikpe@csd.uu.se, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-laptop@vger.kernel.org
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
References: <200305191216.h4JCGONj015081@harpo.it.uu.se> <20030519123119.GA20385@Synopsys.COM> <20030519144130.GM32559@Synopsys.COM>
In-Reply-To: <20030519144130.GM32559@Synopsys.COM>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:
> Alex Riesen, Mon, May 19, 2003 14:31:19 +0200:
> 
>>>>EIP is at fix_processor_context+0x5f/0x100
>>>>Process kapmd (pid: 4, threadinfo=c5f0e000 task=c5fbc640)
>>>
>>>After receiving Alex' .config and gcc version (3.2.3), I've been
>>>able to decipher this. current->mm is NULL in the kapmd task. The call
>>>
>>>	load_LDT(&current->mm->context);	/* This does lldt */
>>>
>>>in fix_processor_context() computes the address of context as
>>>(current->mm)+0x7c, which is 0x7c. load_LDT_nolock() dereferences
>>>0x7c+0x14 (void *segments = pc->ldt) and the oops follows.
>>>
>>>As to _why_ kapmd's current->mm is NULL, I don't know. It isn't
>>>when I test APM suspend in 2.5.69-bk. A lot of code dereferences
>>>current->mm without checking, so I guess current->mm==NULL is a bug.
>>
>>i just go and try it with the latest -bk.
> 
> no change. Still oopses.


Could you try to compile with gcc-3.3? In another thread (2.5.69-mm6:
pccard oops) this helped IIRC. I'm suspecting gcc 3.2.3 generates
incorrect code for some cases.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

