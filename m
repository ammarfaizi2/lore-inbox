Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUG1UdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUG1UdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUG1UdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:33:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:29861 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263555AbUG1UdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:33:04 -0400
Date: Wed, 28 Jul 2004 13:12:57 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [announce][draft3] HVCS for inclusion in 2.6 tree
Message-Id: <20040728131257.1fedf56d.rddunlap@osdl.org>
In-Reply-To: <1091032768.14771.283.camel@localhost>
References: <1089819720.3385.66.camel@localhost>
	<16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	<1090528007.3161.7.camel@localhost>
	<20040722191637.52ab515a.akpm@osdl.org>
	<1090958938.14771.35.camel@localhost>
	<20040727155011.77897e68.rddunlap@osdl.org>
	<1091032768.14771.283.camel@localhost>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004 11:39:29 -0500 Ryan Arnold wrote:

| > +int hvcs_convert(long to_convert)
| > +{
| > +	switch (to_convert) {
| > +		case H_Success:
| > +			return 0;
| > +		case H_Parameter:
| > +			return -EINVAL;
| > +		case H_Hardware:
| > +			return -EIO;
| > +		case H_Busy:
| > 
| > Can these H_values be converted from that coding style?
| 
| Converted to what/how?  I am confused by your question.
and:
| Randy, if you mean you'd like to see H_SUCCESS, H_PARAMETER, etc, I'd
| like to point out that all of the documentation I worked from uses the
| convention you see in my code.  Additionally, all of these hcall return
| codes already exist in include/asm-pp64/hvcall.h and have for some time.

OK, you made me look.  Most of that header file is reasonable except
for that set of #defines (IMO of course).
Being there doesn't mean that it was properly reviewed....
It can just mean that a merger/maintainer trusted whoever sent it
to them not to do undesirable things.

| > 
| > +		/* This is a very small struct and will be freed soon */
| > +		next_partner_info = kmalloc(sizeof(struct hvcs_partner_info),
| > +				GFP_ATOMIC);
| > 
| > Where is it freed?
| > 
| It is freed in hvcs_free_partner_info() because the partner info that is
| allocated needs to have scope outside of the hvcs_get_partner_info()
| call.

I see, thanks.

| > +#define __ALIGNED__	__attribute__((__aligned__(8)))
| > 
| > Why aligned? why 8?  (just curious)  Could use a comment if it's important.
| 
| Randy, here's an explanation given by Hollis Blanchard and Paul
| Mackerras that I'll add to the code as a comment.
| 
| The hcall interface involves putting 8 chars into each of two registers.
| We load up those 2 registers (in arch/ppc64/hvconsole.c) by casting
| char[16] to long[2].  It would work without __ALIGNED__, but a little
| (tiny) bit slower because an unaligned load is slower than aligned load.

Yes, thanks again.

--
~Randy
