Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265110AbUFGW6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUFGW6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUFGW6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:58:34 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:62672 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265108AbUFGW6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:58:21 -0400
Message-ID: <40C4F40A.8060205@elegant-software.com>
Date: Mon, 07 Jun 2004 19:02:34 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <-> getpid()
 bug in 2.6?]
References: <40C1E6A9.3010307@elegant-software.com>	<Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>	<40C32A44.6050101@elegant-software.com>	<40C33A84.4060405@elegant-software.com>	<1086537490.3041.2.camel@laptop.fenrus.com>	<40C3AD9E.9070909@elegant-software.com>	<20040607121300.GB9835@devserv.devel.redhat.com>	<6uu0xn5vio.fsf@zork.zork.net>	<20040607140009.GA21480@infradead.org> <16580.46864.290708.33518@napali.hpl.hp.com>
In-Reply-To: <16580.46864.290708.33518@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:

>>>>>>On Mon, 7 Jun 2004 15:00:09 +0100, Christoph Hellwig <hch@infradead.org> said:
>>>>>>            
>>>>>>
>
>  Christoph> On Mon, Jun 07, 2004 at 02:48:31PM +0100, Sean Neakums
>  Christoph> wrote:
>  >> > for example ia64 doesn't have it.
>
>  >> Then what is the sys_clone2 implementation in
>  >> arch/is64/kernel/entry.S for?
>
>  Christoph> It's clone with a slightly different calling convention.
>
>Note that the only difference is that the stack-area is expressed as a
>range (starting-address + size), rather than a direct stack-pointer
>value.  IMHO, it was a mistake to not do it that way right from the
>beginning (consider that different arches grow stacks in different
>directions, for example).
>
>	
>
So Ia64 does have it..that's good. Does glibc wrap it?

I agree with the above...could glibc's clone() should have a size added? 
Then the arch specific stack issues
could be hidden.

BTW, does gcc have a built-in #define like __STACK_GROWSUP__ that would 
allow one to deal with the missing size parameter
when you called clone() by adjusting what you passed with and #ifdef?.
