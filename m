Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVA0Mnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVA0Mnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 07:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVA0Mnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 07:43:33 -0500
Received: from canuck.infradead.org ([205.233.218.70]:38670 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262596AbVA0Mnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 07:43:32 -0500
Subject: Re: Patch 2/6 introduce helper infrastructure
From: Arjan van de Ven <arjanv@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050127122756.GA48931@muc.de>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101228.GC9760@infradead.org> <m1is5j40iq.fsf@muc.de>
	 <20050127115829.GB10237@infradead.org>  <20050127122756.GA48931@muc.de>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 13:43:23 +0100
Message-Id: <1106829804.5624.86.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 13:27 +0100, Andi Kleen wrote:
> I guess the per MM prng would be still faster, but it's probably
> not worth tweaking unless it shows up as a problem.
> 
> > +	if (end <= start + len)
> > +		return 0;
> > +	return PAGE_ALIGN(get_random_int() % range + start);
> 
> Division through variable is often quite slow, it would be good if you
> avoided it somehow.

it'll be used once per exec() so while you're right I'll not be a huge
problem; rewriting the implementation of this function ought to be
independent of the (later to be introduced) users, the problem is quite
well defined.

