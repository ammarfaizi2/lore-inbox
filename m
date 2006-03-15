Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWCOVcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWCOVcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWCOVcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:32:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42711 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751364AbWCOVci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:32:38 -0500
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
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <20060315211335.GD25361@kvack.org> (Benjamin LaHaise's message
 of "Wed, 15 Mar 2006 16:13:35 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Date: Wed, 15 Mar 2006 14:31:27 -0700
Message-ID: <m1wteve6og.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> writes:

> On Wed, Mar 15, 2006 at 03:05:30PM -0600, Kumar Gala wrote:
>> I disagree.  I think we need to look to see what the "bloat" is  
>> before we go and make start/end config dependent.
>
> Eh?  32 bit kernels get used in embedded systems, which includes those 
> with only 8MB of RAM.  The upper 32 bits will never be anything other 
> than 0.

If the impact is very slight or unmeasurable this means the option
needs to fall under CONFIG_EMBEDDED, where you can change if
every last bit of RAM counts but otherwise you won't care.

>> It seems clear that drivers dont handle the fact that "start"/"end"  
>> change an 32-bit vs 64-bit archs to begin with.  By making this even  
>> more config dependent seems to be asking for more trouble.
>
> You can't get a non-32 bit value on a 32 bit platform, so why should a 
> driver be expected to handle anything?

Having > 32bit values on a 32bit platform is not the issue.

Some drivers appear to puke simply because the value is 64bit.  Which
means the driver will have problems on any 64bit kernel.  That kind
of behavior is worth purging.

Eric
