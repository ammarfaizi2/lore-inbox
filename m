Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWECHHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWECHHg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 03:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWECHHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 03:07:36 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:8967
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965121AbWECHHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 03:07:35 -0400
Message-Id: <4458730F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 03 May 2006 09:08:31 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Martin Bligh" <mbligh@google.com>, "Andrew Morton" <akpm@osdl.org>,
       <apw@shadowen.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com> <200605022209.37205.ak@suse.de> <44586E0E.76E4.0078.0@novell.com> <200605030849.44893.ak@suse.de>
In-Reply-To: <200605030849.44893.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ><EOE>new stack 0 (0 0 0 10082 10)
>> 
>> Looks like <rubbish> <SS> <RSP> <RFLAGS> <CS> to me, ...
>
>Hmm, right.
> 
>> >Hmm weird. There isn't anything resembling an exception frame at the top of the
>> >stack.  No idea how this could happen.
>> 
>> ... which is a valid frame where the stack pointer was corrupted before the exception occurred. One more printed
item
>> (or rather, starting items at estack_end[-1]) would allow at least seeing what RIP this came from.
>
>Any can you add that please and check? 

???

>Also worst case one could dump last branch pointers. AMD unfortunately only has four,
>on Intel with 16 it's easier.

Provided you disable recording early enough. Otherwise only one (last exception from/to) is going to be useful on
both.

>I can provide a patch for that if needed.
>
>> This actually points out another weakness of that code: if you pick up a mis-aligned stack pointer then the
conditions
>> in both the exception and interrupt stack invocations of HANDLE_STACK() won't prevent you from accessing an item
>> crossing a page boundary, and hence potentially faulting. 
>
>Yes it probably should check for that.
>
>> Similarly, obtaining an entirely bad stack pointer anywhere in 
>> that code will result in a fault. I guess the stack reads should really be done using get_user() or some other code
>> having recovery attached.
>
>That can cause recursive exceptions. I'm a bit paranoid with that.

Without doing so it can also cause recursive exceptions, just that this is going to be deadly then.

Jan
