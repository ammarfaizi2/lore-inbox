Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945966AbWJSOWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945966AbWJSOWw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945967AbWJSOWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:22:52 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:23965 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1945966AbWJSOWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:22:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=H8h370sjuTPwImt16FZdn0VlpQ3xTLr1Nzx/PdwMv87RX58b6YTy/USlvvFqbfVlRZbesP+bP3NvkH5Tx5NNee/usEFJcaD9UTca6YVTDFksMhPZ6I212q8rstYd2PIfjixGEfi2wbtFSw+JDRgclu6XQi/8Z5OO2+umhwXhpHw=  ;
Message-ID: <45378A35.5020101@yahoo.com.au>
Date: Fri, 20 Oct 2006 00:22:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       mingo@elte.hu, tglx@linutronix.de
Subject: Re: + i386-time-avoid-pit-smp-lockups.patch added to -mm tree
References: <200610112126.k9BLQqKG002529@shell0.pdx.osdl.net>	 <1161265475.11264.7.camel@c-67-180-230-165.hsd1.ca.comcast.net>	 <200610191547.09640.ak@suse.de> <1161266225.11264.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
In-Reply-To: <1161266225.11264.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Thu, 2006-10-19 at 15:47 +0200, Andi Kleen wrote:
> 
>>On Thursday 19 October 2006 15:44, Daniel Walker wrote:
>>
>>>On Wed, 2006-10-11 at 14:26 -0700, akpm@osdl.org wrote:
>>>
>>>
>>>>diff -puN arch/i386/kernel/i8253.c~i386-time-avoid-pit-smp-lockups arch/i386/kernel/i8253.c
>>>>--- a/arch/i386/kernel/i8253.c~i386-time-avoid-pit-smp-lockups
>>>>+++ a/arch/i386/kernel/i8253.c
>>>>@@ -109,7 +109,7 @@ static struct clocksource clocksource_pi
>>>> 
>>>> static int __init init_pit_clocksource(void)
>>>> {
>>>>-	if (num_possible_cpus() > 4) /* PIT does not scale! */
>>>>+	if (num_possible_cpus() > 1) /* PIT does not scale! */
>>>> 		return 0;
>>>> 
>>>
>>>Can we ifdef some code here on CONFIG_SMP . It bugs me that there just
>>>dead code laying around on smp systems.
>>
>>The optimizer should optimize it all out since num_possible_cpus() is a 0
>>constant on UP.
> 
> 
> You just mean the if statement above though? I was talking more about
> the structure above this called "clocksource_pit" which isn't used on
> SMP systems due to this code addition. AFAIK init_pit_clocksource()
> could disappear along with the clocksource structure ..

An SMP kernel can boot on UP hardware, in which case I think
num_possible_cpus() will be 1, won't it?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
