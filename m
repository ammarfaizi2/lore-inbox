Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTKKDAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264230AbTKKDAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:00:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:44161 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264229AbTKKDAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:00:41 -0500
Date: Mon, 10 Nov 2003 18:59:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Andrew Morton <akpm@osdl.org>, Dag Brattli <dag@brattli.net>,
       Jean Tourrilhes <jt@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <irda-users@lists.sourceforge.net>
Subject: Re: [PATCH] irda: fix type of struct irda_ias_set.attribute.irda_attrib_string.len
In-Reply-To: <20031111020608.GA1208@conectiva.com.br>
Message-ID: <Pine.LNX.4.44.0311101856130.2881-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Nov 2003, Arnaldo Carvalho de Melo wrote:
> 
> Ok, ias_opt->attribute.irda_attrib_string.len is __u8, but
> IAS_MAX_STRING = 256... so attribute.irda_attrib_string.len has to be at least
> __u18, this patch fix this, please see if it is appropriate and if it is so,
> apply.

No, please don't. This 
 (a) changes ABI structures that are exported to user space
 (b) is unnecessary - since the problem is the _warning_, not the test.

Just shut the warning up by either removing the test (replacing it with a 
comment about why it's unnecessary), or by adding a cast, ie

	unsigned int len = ias_opt->attribute.irda_attrib_string.len;

	if (len > IAS_MAX_STRING) {
		...

in case the code ever expects IAS_MAX_STRING to be shorter (or if the type 
is ever changed).

		Linus

