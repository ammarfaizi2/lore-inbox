Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUDBU1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 15:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbUDBU1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 15:27:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:8100 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264170AbUDBU07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 15:26:59 -0500
Subject: Re: [Patch 5/23] mask v2 - Add new mask.h file
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040401131129.4329336f.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
	 <20040401131129.4329336f.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080937563.9787.109.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 02 Apr 2004 12:26:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 13:11, Paul Jackson wrote:
> Patch_5_of_23 - New mask ADT
> 	Adds new include/linux/mask.h header file
> 
> 	==> See this mask.h header for more extensive mask documentation <==

<snip>

> +/* Use if nbits <= BITS_PER_LONG */
> +#define MASK_ALL1(nbits)						\
> +{ {									\
> +	[BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)		\
> +} }
> +
> +/* Use if nbits > BITS_PER_LONG */
> +#define MASK_ALL2(nbits)						\
> +{ {									\
> +	[0 ... BITS_TO_LONGS(nbits)-2] = ~0UL,				\
> +	[BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)		\
> +} }

Gotta say, I'm not a bit fan of the names of these macros.  They're
disappointingly short on descriptiveness.  ;)  Maybe
MASK_ALL_SINGLE_LONG and MASK_ALL_MULTIPLE_LONG?  Something that more
explicitly shows the difference between them.  So when we're reading
code later on, we're not constantly looking up the definition and
saying, "What's the difference between MASK_ALL1 & MASK_ALL2 again?"

-Matt

