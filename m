Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318501AbSHURS2>; Wed, 21 Aug 2002 13:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSHURS2>; Wed, 21 Aug 2002 13:18:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26603 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318501AbSHURS1>; Wed, 21 Aug 2002 13:18:27 -0400
Message-ID: <3D63CC35.6030404@us.ibm.com>
Date: Wed, 21 Aug 2002 10:21:57 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020808
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: "Feldman, Scott" <scott.feldman@intel.com>,
       "'Troy Wilson'" <tcw@tempest.prismnet.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
       tcw@prismnet.com
Subject: Re: mdelay causes BUG, please use udelay
References: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com> <2544596606.1029920638@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>-    msec_delay(10);
>>>+    usec_delay(10000);
>>
>>Jeff, 10000 seems on the border of what's OK.  If it's acceptable, 
>>then let's go for that.  Otherwise, we're going to have to chain 
>>several mod_timer callbacks together to do a controller reset.
> 
> Whilst this sort of delay in interrupt context is undoubtedly bad
> any way we do it, I'd question the context a little more before we
> make a decision. This is called from e1000_reset_hw - are we likely
> to ever actually call this except under initialisation?

It doesn't happen often, or under good circumstances.  In certain 
cases, the driver detects that something timed out and it assumes 
something on the card to be dead.  Instead of delaying the 
reinitialization of the dead card with a timer, they just do it during 
the interrupt where the problem was detected.


-- 
Dave Hansen
haveblue@us.ibm.com

