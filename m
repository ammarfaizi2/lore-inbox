Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271683AbTGRD5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 23:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271688AbTGRD5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 23:57:13 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:18395 "HELO
	develer.com") by vger.kernel.org with SMTP id S271683AbTGRD5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 23:57:12 -0400
Message-ID: <3F17743D.2090006@develer.com>
Date: Fri, 18 Jul 2003 06:14:53 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, torvalds@osdl.org
Subject: Re: do_div64 generic
References: <3F1360F4.2040602@mvista.com>	<3F149747.3090107@mvista.com>	<200307162033.34242.bernie@develer.com>	<200307172310.48918.bernie@develer.com>	<20030717141608.5f1b7710.akpm@osdl.org>	<3F172CDB.3000005@mvista.com> <20030717201905.6ab4a90f.akpm@osdl.org>
In-Reply-To: <20030717201905.6ab4a90f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>>Ths one's OK by me.  Let's just fix the bug with minimum risk and churn.
>>
>> Uh, bug?  I was not aware that there was a bug.  As far as I know, 
>> nothing is broken.
> 
> wtf?  Then why are people running around brandishing big scary patches
> at me?

ROTFL! :-)

I've been asked by George to add generic support for the existing
div_long_long_rem() inline function.

The patch might be big, but not that much scary... I'm just replacing
two local redefinitions of the macro with a single inline in
asm-generic/div64.h. It's more a cleanup than a bug fix.

The patch also takes care of the few archs that wrote their own
optimized versions of do_div(). For those, I've implemented
div_long_long_rem() in terms of do_div() because it might still
be better than the generic version. I've left a FIXME there to
let the arch maintainers know that these could be better optimized.

And, as a special bonus, the patch also adds missing parentheses
around do_div() arguments in asm-arm/div64.h. This is the only real
bug being fixed.



