Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTKKRSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTKKRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:18:31 -0500
Received: from palrel13.hp.com ([156.153.255.238]:33765 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263593AbTKKRSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:18:30 -0500
Date: Tue, 11 Nov 2003 09:18:29 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Andrew Morton <akpm@osdl.org>, Dag Brattli <dag@brattli.net>,
       Jean Tourrilhes <jt@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: Re: [PATCH] irda: fix type of struct irda_ias_set.attribute.irda_attrib_string.len
Message-ID: <20031111171829.GA18882@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031111020608.GA1208@conectiva.com.br> <Pine.LNX.4.44.0311101856130.2881-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311101856130.2881-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 06:59:59PM -0800, Linus Torvalds wrote:
> 
> On Tue, 11 Nov 2003, Arnaldo Carvalho de Melo wrote:
> > 
> > Ok, ias_opt->attribute.irda_attrib_string.len is __u8, but
> > IAS_MAX_STRING = 256... so attribute.irda_attrib_string.len has to be at least
> > __u18, this patch fix this, please see if it is appropriate and if it is so,
> > apply.
> 
> No, please don't. This 
>  (a) changes ABI structures that are exported to user space

	Yes ! You are 100% correct, changing this would break all the
IrDA user space, which I'm not keen on doing.

>  (b) is unnecessary - since the problem is the _warning_, not the test.
> 
> Just shut the warning up by either removing the test (replacing it with a 
> comment about why it's unnecessary), or by adding a cast, ie
> 
> 	unsigned int len = ias_opt->attribute.irda_attrib_string.len;
> 
> 	if (len > IAS_MAX_STRING) {
> 		...
> 
> in case the code ever expects IAS_MAX_STRING to be shorter (or if the type 
> is ever changed).

	Yes, in this case the test should be removed with a comment.

> 		Linus

	Jean
