Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWCOVea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWCOVea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWCOVe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:34:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44759 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751488AbWCOVeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:34:23 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
 "struct resource"
References: <20060315193114.GA7465@in.ibm.com>
	<20060315205306.GC25361@kvack.org>
	<46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Mar 2006 14:15:29 -0700
In-Reply-To: <46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org> (Kumar
 Gala's message of "Wed, 15 Mar 2006 15:05:30 -0600")
Message-ID: <m1bqw7flzi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@kernel.crashing.org> writes:

> On Mar 15, 2006, at 2:53 PM, Benjamin LaHaise wrote:
>
>> On Wed, Mar 15, 2006 at 02:31:14PM -0500, Vivek Goyal wrote:
>>> Is there a reason why "start" and "end" field of "struct resource"  are of
>>> type unsigned long. My understanding is that "struct resource" can  be used
>>> to represent any system resource including physical memory. But  unsigned
>>> long is not suffcient to represent memory more than 4GB on PAE  systems.
>>> and compiler starts throwing warnings.
>>
>> Please make this depend on the kernel being compiled with PAE.  We  don't
>> need to bloat 32 bit kernels needlessly.
>
> I disagree.  I think we need to look to see what the "bloat" is  before we go
> and make start/end config dependent.
>
> It seems clear that drivers dont handle the fact that "start"/"end"  change an
> 32-bit vs 64-bit archs to begin with.  By making this even  more config
> dependent seems to be asking for more trouble.

Especially as all resource access are rare slow path operations.

Depending on PAE and the like look like an optimization to consider after
getting the parts working.

Eric
