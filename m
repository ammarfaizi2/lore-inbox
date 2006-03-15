Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWCOWId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWCOWId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWCOWId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:08:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8152 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751434AbWCOWIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:08:32 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Kumar Gala <galak@kernel.crashing.org>, Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
 "struct resource"
References: <20060315193114.GA7465@in.ibm.com>
	<20060315205306.GC25361@kvack.org>
	<46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org>
	<20060315211335.GD25361@kvack.org>
	<m1y7zbe6rn.fsf@ebiederm.dsl.xmission.com>
	<20060315212841.GE25361@kvack.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Mar 2006 14:59:54 -0700
In-Reply-To: <20060315212841.GE25361@kvack.org> (Benjamin LaHaise's message
 of "Wed, 15 Mar 2006 16:28:41 -0500")
Message-ID: <m13bhje5d1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> writes:

> On Wed, Mar 15, 2006 at 02:29:32PM -0700, Eric W. Biederman wrote:
>> If the impact is very slight or unmeasurable this means the option
>> needs to fall under CONFIG_EMBEDDED, where you can change if
>> every last bit of RAM counts but otherwise you won't care.
>
> But we have a data type that is correct for this usage: dma_addr_t.

Actually now that I think back there are machines with < 4GiB of ram
with 64bit pci BAR values.  It is more common to have 32bit values BAR
values and > 4GiB of ram.

So I don't see dma_addr_t in general being the right choice.

Although I do suspect that in most cases dma_addr_t <= the
size of what is in struct resource.

Nor do I think struct resource is nearly as important when being
efficient, as dma_addr_t.  struct resource is only used during
driver setup which is a very rare event.  A few extra instructions
there likely will get lost in the noise and most of the will probably
be removed because they are in an __init section anyway.

Eric
