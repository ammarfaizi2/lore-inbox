Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVEPVJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVEPVJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVEPVHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:07:54 -0400
Received: from dvhart.com ([64.146.134.43]:58529 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261876AbVEPVGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:06:23 -0400
Date: Mon, 16 May 2005 14:06:14 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: christoph <christoph@scalex86.org>, Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, shai@scalex86.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Factor in buddy allocator alignment requirements in node memory alignment
Message-ID: <737010000.1116277574@flay>
In-Reply-To: <Pine.LNX.4.62.0505161253090.20839@ScMPusgw>
References: <Pine.LNX.4.62.0505161204540.4977@ScMPusgw> <1116274451.1005.106.camel@localhost>  <Pine.LNX.4.62.0505161240240.13692@ScMPusgw><1116276439.1005.110.camel@localhost> <Pine.LNX.4.62.0505161253090.20839@ScMPusgw>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, May 16, 2005 12:55:39 -0700 christoph <christoph@scalex86.org> wrote:

> On Mon, 16 May 2005, Dave Hansen wrote:
> 
>> > Because the buddy allocator is complaining about wrongly allocated zones!
>> 
>> Just because it complains doesn't mean that anything is actually
>> wrong :)
>> 
>> Do you know which pieces of code actually break if the alignment doesn't
>> meet what that warning says?
> 
> I have seen nothing break but 4 MB allocations f.e. will not be allocated 
> on a 4MB boundary with a 2 MB zone alignment. The page allocator always 
> returnes properly aligned pages but 4MB allocations are an exception? 
> 
> Some present or future hardware device or some other code may find that 
> surprising and crash.

Now that it's fixed it is meant to notice that the start of the zone is
not aligned, and not key off that, but the aligment itself ... the start
and end roundoff bits shouldn't throw the rest out of alignment, as long
as we do the calculation sensibly for how we regroup buddies.

M.

