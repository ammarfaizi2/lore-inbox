Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUIWHSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUIWHSB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 03:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIWHSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 03:18:01 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:11669 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S268303AbUIWHR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 03:17:56 -0400
Message-ID: <41527885.8020402@myrealbox.com>
Date: Thu, 23 Sep 2004 00:17:25 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com, ak@muc.de,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch V8: [4/7] universally available
 cmpxchg on i386
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com> <20040920205752.GH4242@wotan.suse.de> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua> <20040921154542.GB12132@wotan.suse.de>
In-Reply-To: <20040921154542.GB12132@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, Sep 21, 2004 at 06:41:25PM +0300, Denis Vlasenko wrote:
> 
>>On Monday 20 September 2004 23:57, Andi Kleen wrote:
>>
>>>On Mon, Sep 20, 2004 at 01:49:20PM -0700, Christoph Lameter wrote:
>>>
>>>>On Mon, 20 Sep 2004, Denis Vlasenko wrote:
>>>>
>>>>
>>>>>I think it shouldn't be this way.
>>>>>
>>>>>OTOH for !CONFIG_386 case it makes perfect sense to have it inlined.
>>>>
>>>>Would the following revised patch be acceptable?
>>>
>>>You would need an EXPORT_SYMBOL at least. But to be honest your
>>>original patch was much simpler and nicer and cmpxchg is not called
>>>that often that it really matters. I would just ignore Denis' 
>>>suggestion and stay with the old patch.
>>
>>A bit faster approach (for CONFIG_386 case) would be using
> 
> 
> It's actually slower. Many x86 CPUs cannot predict indirect jumps
> and those that do cannot predict them as well as a test and jump.

Wouldn't alternative_input() choosing between a cmpxchg and a call be 
the way to go here?  Or is the overhead too high in an inline function?

(No patch included since I don't pretend to understand gcc's asm syntax 
at all.)

--Andy
