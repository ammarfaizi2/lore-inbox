Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751828AbWFVPxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbWFVPxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWFVPxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:53:20 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:42971 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751827AbWFVPxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:53:19 -0400
Date: Thu, 22 Jun 2006 17:53:17 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Nathan Lynch <ntl@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 6/6] cpu_relax(): ptrace.c coding style fix
Message-ID: <20060622155317.GA9746@rhlx01.fht-esslingen.de>
References: <20060621210046.GF22516@rhlx01.fht-esslingen.de> <20060622143223.GK16029@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622143223.GK16029@localdomain>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 09:32:23AM -0500, Nathan Lynch wrote:
> Andreas Mohr wrote:
> > 
> > Fix existing cpu_relax() loop to have proper kernel style.
> > 
> 
> ...
> 
> > @@ -182,9 +182,8 @@
> >  	if (!write_trylock(&tasklist_lock)) {
> >  		local_irq_enable();
> >  		task_unlock(task);
> > -		do {
> > +		while (!write_can_lock(&tasklist_lock))
> >  			cpu_relax();
> > -		} while (!write_can_lock(&tasklist_lock));
> 
> This is a change in behavior, not just style.  (And there is nothing
> wrong with the current style.)

Ick, right, this could cause the new state to be visible in the 2nd iteration
only.

Thanks! Discard this change please.

Andreas Mohr
