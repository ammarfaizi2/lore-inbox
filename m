Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVDTOax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVDTOax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 10:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVDTOaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 10:30:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40087 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261646AbVDTOaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 10:30:35 -0400
Subject: Re: [RFC][PATCH] nameing reserved pages [0/3]
From: Arjan van de Ven <arjan@infradead.org>
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       hari@in.ibm.com
In-Reply-To: <426663E8.3080502@jp.fujitsu.com>
References: <426644DA.70105@jp.fujitsu.com>
	 <1114000447.6238.64.camel@laptopd505.fenrus.org>
	 <426663E8.3080502@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 16:30:30 +0200
Message-Id: <1114007431.6238.79.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 23:15 +0900, Kamezawa Hiroyuki wrote:
> Arjan van de Ven wrote:
> 
> >>For example, Memory Hotplug can ignore (a).
> >>    
> >>
> >
> >Memory Hotplug can also use page_is_ram().
> >  
> >
> Yes. we can use page_is_ram() for finding (a)memory hole.
> But I'd like to catch other removable PG_reserved pages like (d)Isorated 
> by MCA (e)used by perfmon and
> some of (b) used by kernerl and (c) Set by drivers.
> What I'm thinking of is to detect whether memory is hot-removable or not 
> before removing actually.

MCA's probably shouldn't set PG_reserved; I don't see why they should.
They could just steal the page and "leak" it.

> 
> >/dev/memstate really looks like a bad idea to me as well... I rather
> >have less than more /dev/*mem*
> >  
> >
> For showing page usage and its "location", I've thought of other 
> interface, sysfs, procfs...
> But I have no idea.

Why do you want this exported to userspace? There is absolutely no way
you can get this exported race free without shutting the VM down, and
without being race free this information has absolutely no meaning !!
(and when you shut the VM down you really shouldn't depend on userspace
anymore either)



