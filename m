Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUG1S6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUG1S6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUG1S6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:58:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8950 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262322AbUG1S6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:58:36 -0400
Subject: Re: [announce][draft3] HVCS for inclusion in 2.6 tree
From: Ryan Arnold <rsa@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20040727155011.77897e68.rddunlap@osdl.org>
References: <1089819720.3385.66.camel@localhost>
	 <16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	 <1090528007.3161.7.camel@localhost> <20040722191637.52ab515a.akpm@osdl.org>
	 <1090958938.14771.35.camel@localhost>
	 <20040727155011.77897e68.rddunlap@osdl.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1091032768.14771.283.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 11:39:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 17:50, Randy.Dunlap wrote:
> +struct hvcs_partner_info {};
> 
> Ugly comments style.  Which comment goes with which
> data?  Commenting data can be very helpful, but most of these
> are close to useless since they are so obvious.
> And put a space after "/*".

Right, this is definitely more obvious now.  I think I can pretty much
remove the comments now that the element names make sense.

> +int hvcs_convert(long to_convert)
> +{
> +	switch (to_convert) {
> +		case H_Success:
> +			return 0;
> +		case H_Parameter:
> +			return -EINVAL;
> +		case H_Hardware:
> +			return -EIO;
> +		case H_Busy:
> 
> Can these H_values be converted from that coding style?

Converted to what/how?  I am confused by your question.

> 
> +		/* This is a very small struct and will be freed soon */
> +		next_partner_info = kmalloc(sizeof(struct hvcs_partner_info),
> +				GFP_ATOMIC);
> 
> Where is it freed?
> 
It is freed in hvcs_free_partner_info() because the partner info that is
allocated needs to have scope outside of the hvcs_get_partner_info()
call.

>  config PC9800_OLDLP
> 
> This patch segment won't apply since PC9800 has been removed.

I'll make future patches against 2.6.8-rc2.

> +#define __ALIGNED__	__attribute__((__aligned__(8)))
> 
> Why aligned? why 8?  (just curious)  Could use a comment if it's important.

Randy, here's an explanation given by Hollis Blanchard and Paul
Mackerras that I'll add to the code as a comment.

The hcall interface involves putting 8 chars into each of two registers.
We load up those 2 registers (in arch/ppc64/hvconsole.c) by casting
char[16] to long[2].  It would work without __ALIGNED__, but a little
(tiny) bit slower because an unaligned load is slower than aligned load.

I took care of all the other formatting things you pointed out.

Thanks for the suggestions Randy.  Hopefully I'll have a patch out this
afternoon encompassing your suggestions.

Ryan S. Arnold
IBM Linux Technology Center

