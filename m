Return-Path: <linux-kernel-owner+w=401wt.eu-S932953AbWL0PNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953AbWL0PNF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbWL0PNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:13:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36010 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953AbWL0PND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:13:03 -0500
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and
	2.6.x kernels
From: Arjan van de Ven <arjan@infradead.org>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <927934.92732.qm@web32603.mail.mud.yahoo.com>
References: <927934.92732.qm@web32603.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 27 Dec 2006 16:13:00 +0100
Message-Id: <1167232380.3281.3938.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
>  one piece of information that Ganglia collects for a node is the
> "number of CPUs", originally meaning "physical CPUs".

Ok I was afraid of that.

>  With the
> introduction of HT and multi-core things are a bit more complex now. We
> have decided that HT sibblings do not qualify as "real" CPUs, while
> multi-cores do.

I think that decision is a mistake, and is probably based on experiences
with the first generation of HT capable Pentium 4 processors.

The original p4 HT to a large degree suffered from a too small cache
that now was shared. SMT in general isn't per se all that different in
performance than dual core, at least not on a fundamental level, it's
all a matter of how many resources each thread has on average. With dual
core sharing the cache for example, that already is part HT. Putting the
"boundary" at HT-but-not-dual-core is going to be highly artificial and
while it may work for the current hardware, in general it's not a good
way of separating things (just look at the PowerPC processors, those are
highly SMT as well), and I suspect that your distinction is just going
to break all the time over the next 10 years ;) Or even today on the
current "large cache" P4 processors with HT it already breaks. (just
those tend to be the expensive models so more rare)

I would strongly urge you to reconsider this decision; if you want to
show "sockets" that sounds reasonable, or even if you want to do it on
the "bus sharing" level (FSB/HT), but HT.. just sounds wrong.



  

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

