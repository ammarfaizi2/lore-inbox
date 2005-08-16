Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVHPX4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVHPX4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVHPX4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:56:17 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:63500 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750739AbVHPX4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:56:16 -0400
Message-ID: <43027D20.7020907@vmware.com>
Date: Tue, 16 Aug 2005 16:56:16 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwame@arm.linux.org.uk
Subject: Re: [PATCH 5/14] i386 / Use early clobber to eliminate rotate in
 desc
References: <200508110454.j7B4sBDK019538@zach-dev.vmware.com> <20050816234514.GG27628@wotan.suse.de>
In-Reply-To: <20050816234514.GG27628@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 23:55:56.0749 (UTC) FILETIME=[0B5457D0:01C5A2BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Wed, Aug 10, 2005 at 09:54:11PM -0700, zach@vmware.com wrote:
>  
>
>>Use an early clobber on addr to avoid the extra rorl instruction at the
>>end of _set_tssldt_desc.
>>    
>>
>
>I would suggest to just use C for this. I do this on x86-64 and 
>I don't think there is any reason to use this hard to maintain
>code for it.
>

This one in particular is non-optimal looking from C because the 
compiler misses the potential for rotation.  But, composing into 
temporaries and then issuing two writes to memory instead of multiple 
writes within the same word could actually get you a better cycle count, 
and that is something GCC just might be able to do :)

Zach
