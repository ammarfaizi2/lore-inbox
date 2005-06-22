Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVFVVDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVFVVDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVFVVDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:03:45 -0400
Received: from saturn.billgatliff.com ([209.251.101.200]:41148 "EHLO
	saturn.billgatliff.com") by vger.kernel.org with ESMTP
	id S262276AbVFVU70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:59:26 -0400
Message-ID: <42B9D120.6030108@billgatliff.com>
Date: Wed, 22 Jun 2005 15:59:12 -0500
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com> <84144f020506221243163d06a2@mail.gmail.com> <20050622203211.GI8907@alpha.home.local>
In-Reply-To: <20050622203211.GI8907@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy:

Willy Tarreau wrote:

>Hi,
>
>On Wed, Jun 22, 2005 at 10:43:40PM +0300, Pekka Enberg wrote:
>  
>
>>On 6/22/05, Bouchard, Sebastien <Sebastien.Bouchard@ca.kontron.com> wrote:
>>    
>>
>>>+#define TLCLK_REG7 TLCLK_BASE+7
>>>      
>>>
>>Please use enums instead.
>>    
>>
>
>I dont agree with you here : enums are good to simply specify an ordering.
>But they must not be used to specify static mapping. Eg: if REG4 *must* be
>equal to BASE+4, you should not use enums, otherwise it will render the
>code unreadable. I personnaly don't want to count the position of REG7 in
>the enum to discover that it's at BASE+7.
>  
>

What Sebastien is after is something like this:

	enum tclk_regid {TCLK_BASE=0xa80, TCLK_REG0=TCLK_BASE, TCLK_REG1=TCLK_BASE+1...};
	enum tclk_regid tclk;

And then later on, if you ask gdb with the value of tclk is, it can tell you "TCLK_REG1", instead of just 0xa801.  You can also assign values to tclk from within gdb using the enumerations, rather than magic numbers.

If you insist on using #defines, then you need to do them like this at the very least:

	#define TCLK_REG7 (TCLK_BASE+7)

... so as to prevent operator precedence problems later on.  I.e. what happens here:

	tclk = TCLK_REG7 / 2;

Not implying that the above is a realistic example, I'm just pointing out a potential gotcha that is easily avoided...



b.g.

-- 
Bill Gatliff
"A DTI spokesman said Wicks would use his debut announcement to
'reaffirm the government's commitment to developing wind' to tackle
the threat of climate change." -- The Observer, May 22, 2005
bgat@billgatliff.com

