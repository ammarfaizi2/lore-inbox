Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTKIAbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 19:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTKIAbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 19:31:09 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:26380
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261802AbTKIAbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 19:31:06 -0500
Subject: Re: 2.4.23pre mm/slab.c error
From: Robert Love <rml@tech9.net>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20031107093114.00a8bec8@pop.t-online.de>
References: <5.1.0.14.2.20031107093114.00a8bec8@pop.t-online.de>
Content-Type: text/plain
Message-Id: <1068337871.27320.222.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 08 Nov 2003 19:31:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-07 at 03:36, Margit Schubert-While wrote:
> At lines 1786 to 1793 in mm/slab.c we have :
>                  while (p != &searchp->slabs_free) {
> #if DEBUG
>                          slabp = list_entry(p, slab_t, list);
> 
>                          if (slabp->inuse)
>                                  BUG();
> #endif
>                          full_free++;
> 
> I think the "slabp =" should be above the "#if DEBUG".
> Or ?

Looks to me like nothing else uses slabp here but that if, so it is fine
to move it inside the DEBUG.  It was outside the DEBUG in 2.4.22 and
earlier kernels, but moving it inside seems a safe optimization to me.

slabp is not used again until line ~1840, where it is given a new value.

	Robert Love


