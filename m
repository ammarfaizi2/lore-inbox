Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWCOVvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWCOVvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWCOVvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:51:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61655 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750738AbWCOVvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:51:37 -0500
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
Date: Wed, 15 Mar 2006 14:50:24 -0700
In-Reply-To: <20060315212841.GE25361@kvack.org> (Benjamin LaHaise's message
 of "Wed, 15 Mar 2006 16:28:41 -0500")
Message-ID: <m1fylje5sv.fsf@ebiederm.dsl.xmission.com>
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

Well the name is wrong.  Because these are in general not DMA addresses,
but it may have the other desired properties.  So it may be
useable.

>> Having > 32bit values on a 32bit platform is not the issue.
>> 
>> Some drivers appear to puke simply because the value is 64bit.  Which
>> means the driver will have problems on any 64bit kernel.  That kind
>> of behavior is worth purging.
>
> Forcing it to be a 64 bit value doesn't fix that problem, so that isn't 
> a valid excuse for adding bloat.

It doesn't fix it but it finds it.  Which is half the battle.  Once
the existing references are fixed up it makes it hard to introduce new
breakage like that, because more people see it.

As for bloat this assumes there will be some measurable bloat.
Resources are used in such a limited fashion I will be surprised if
you can measure any bloat.

Eric
