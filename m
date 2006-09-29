Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWI2IlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWI2IlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWI2IlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:41:10 -0400
Received: from gw.goop.org ([64.81.55.164]:56012 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161415AbWI2IlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:41:09 -0400
Message-ID: <451CDC31.6060407@goop.org>
Date: Fri, 29 Sep 2006 01:41:21 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
References: <20060928225444.439520197@goop.org> >	  <20060928225452.229936605@goop.org>> <1159506427.25820.20.camel@localhost.localdomain>
In-Reply-To: <1159506427.25820.20.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
>> +       printk(KERN_EMERG "------------[ cut here ]------------\n");
>>     
>
> I'm not sure I'm big on the cut here marker.
>   

x86 has it.  I figured its more important to not change x86 output than 
powerpc.

>> i386 implements CONFIG_DEBUG_BUGVERBOSE, but x86-64 and powerpc do
>> not.  This should probably be made more consistent.
>>     
>
> It looks like if you do this you _might_ be able to share struct
> bug_entry, or at least have consistent members for each arch. Which
> would eliminate some of the inlines you have for accessing the bug
> struct.
>   
Yeah, its a bit of a toss-up.  powerpc wants to hide the warn flag 
somewhere, which either means having a different structure, or using the 
fields differently.  CONFIG_DEBUG_BUGVERBOSE supporters (ie, i386) want 
to make the structure completely empty in the !DEBUG_BUGVERBOSE case 
(which doesn't currently happen).
> It needed a bit of work to get going on powerpc:
>   

Thanks.  I'll try to fold all this together into a new patch when things 
settle down.

    J
