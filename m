Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTDKRSu (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTDKRSu (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:18:50 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59371 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261440AbTDKRSs (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 13:18:48 -0400
Date: Fri, 11 Apr 2003 10:29:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: davidm@hpl.hp.com
Cc: alan@lxorguk.ukuu.org.uk, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: proc_misc.c bug
Message-Id: <20030411102946.685a907c.rddunlap@osdl.org>
In-Reply-To: <16022.21891.554860.506152@napali.hpl.hp.com>
References: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
	<1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
	<20030410154902.32f48f9c.rddunlap@osdl.org>
	<32880.4.64.197.106.1050037303.squirrel@webmail.osdl.org>
	<16022.21891.554860.506152@napali.hpl.hp.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Apr 2003 22:41:23 -0700 David Mosberger <davidm@napali.hpl.hp.com> wrote:

| >>>>> On Thu, 10 Apr 2003 22:01:43 -0700 (PDT), "Randy.Dunlap" <rddunlap@osdl.org> said:
| 
|   Randy> OK, I've looked at it and concluded that it's not bad the way
|   Randy> it is (after David's patch is applied).  However, that really
|   Randy> depends on whether the static NR_CPUS is well-tuned or not.
|   Randy> If it's not tuned, then modifying the output to use the
|   Randy> iterative seq_file methods would make sense.  But if it's not
|   Randy> tuned, someone is (usually) wasting lots of memory anyway.
| 
|   Randy> [snip...]
| 
|   Randy> Does someone want to disagree now?  go ahead...i'm listening.
|   Randy> Maybe the reason to modify it is that NR_CPUS is not a good
|   Randy> approximation/hint/clue.
| 
| Wouldn't the kmalloc() likely fail in fragmented conditions?  Also,
| I'm wondering whether there is such a thing as "well-tuned" in this
| case.  For example, in the extreme case of the SGI SN2 machine, each
| CPU could in theory have up to 256 interrupt sources (OK, perhaps it's
| only 256 interrupts per 2 CPUs, but it's still a lot of interrupts to
| go around ;-).  OTOH, most ia64 machines out there have less than 256
| interrupt per _system_.  That's a large variation.

For kmalloc() failing, do you mean the first (large) kmalloc() or the
repeated ones that grow in size each time?
I would think that just doing one big kmalloc up front is desireable
to repeated ones...if the first one does a decent estimate of its max
size.  I just don't know how likely that is.

--
~Randy   ['tangent' is not a verb...unless you believe that
          "in English any noun can be verbed."]
