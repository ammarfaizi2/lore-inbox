Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270562AbTGSXh7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 19:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270564AbTGSXh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 19:37:59 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:41994 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S270562AbTGSXh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 19:37:58 -0400
Date: Sun, 20 Jul 2003 09:52:33 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jim Keniston <jkenisto@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <jgarzik@pobox.com>, <alan@lxorguk.ukuu.org.uk>, <rddunlap@osdl.org>,
       <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH] [1/2] kernel error reporting (revised)
In-Reply-To: <3F1882CF.538FE76@us.ibm.com>
Message-ID: <Mutt.LNX.4.44.0307200951210.21994-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003, Jim Keniston wrote:

> > Yes, this makes sense.  At the kerror.c level, just return -EDEADLK if in_irq().
> > Delay packet delivery (via a tasklet, as before) at the evlog.c level instead.
> > That way, we know at the evlog.c level (in the tasklet) whether the event packet
> > was delivered to anybody, and can paraphrase it to printk if it wasn't.
> >
> > Is this the sort of thing you had in mind?

Not exactly -- I don't think the logging framework should do any irq 
detection.  The caller should either know if its in an interrupt, or do 
the detection itself.


- James
-- 
James Morris
<jmorris@intercode.com.au>


