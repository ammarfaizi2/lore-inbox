Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVHQPzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVHQPzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVHQPzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 11:55:09 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:47055 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751132AbVHQPzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 11:55:08 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <43035DB9.7020709@zytor.com>
Date: Wed, 17 Aug 2005 08:54:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@suse.de>, akpm@osdl.org,
       chrisl@vmware.com, chrisw@osdl.org, Keir.Fraser@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, m+Ian.Pratt@cl.cam.ac.uk,
       mbligh@mbligh.org, pratap@vmware.com, virtualization@lists.osdl.org,
       zwame@arm.linux.org.uk
Subject: Re: [PATCH 5/14] i386 / Use early clobber to eliminate rotate in
 desc
References: <200508110454.j7B4sBDK019538@zach-dev.vmware.com>	 <20050816234514.GG27628@wotan.suse.de> <43027D20.7020907@vmware.com>	 <43027F6C.4070801@zytor.com> <1124288543.773.31.camel@localhost.localdomain>
In-Reply-To: <1124288543.773.31.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2005-08-16 at 17:06 -0700, H. Peter Anvin wrote:
> 
>>At least i386 and x86-64 gcc should recognize
>>
>>	((foo << x) + (foo >> (32-x)))
>>
>>... as a 32-bit rotate
> 
> 
> Only for  1 <= x <= 31. For the x = 0 case the code posted is undefined
> and at least in some cases gcc will do "interesting" things as a result
> such as treating >> 32 as >> 0.
> 

True, although I thought gcc considered the above an idiom and would 
generate a rotate instruction.  Perhaps it should be | rather than +.

	-hpa
