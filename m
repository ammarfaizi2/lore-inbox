Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVHQAHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVHQAHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVHQAHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:07:05 -0400
Received: from terminus.zytor.com ([209.128.68.124]:52408 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750755AbVHQAHC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:07:02 -0400
Message-ID: <43027F6C.4070801@zytor.com>
Date: Tue, 16 Aug 2005 17:06:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Andi Kleen <ak@suse.de>, akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwame@arm.linux.org.uk
Subject: Re: [PATCH 5/14] i386 / Use early clobber to eliminate rotate in
 desc
References: <200508110454.j7B4sBDK019538@zach-dev.vmware.com> <20050816234514.GG27628@wotan.suse.de> <43027D20.7020907@vmware.com>
In-Reply-To: <43027D20.7020907@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> 
> This one in particular is non-optimal looking from C because the 
> compiler misses the potential for rotation.  But, composing into 
> temporaries and then issuing two writes to memory instead of multiple 
> writes within the same word could actually get you a better cycle count, 
> and that is something GCC just might be able to do :)
> 

At least i386 and x86-64 gcc should recognize

	((foo << x) + (foo >> (32-x)))

... as a 32-bit rotate; similar for 8-, 16- and 64-bit rotates of 
appropriate sized items.  Also, it seems it could just be an inline 
function instead of a macro.

	-hpa

