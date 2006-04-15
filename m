Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWDOAHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWDOAHY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 20:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWDOAHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 20:07:24 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:30688 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751344AbWDOAHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 20:07:24 -0400
Date: Sat, 15 Apr 2006 09:06:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
Message-Id: <20060415090639.dde469e8.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
	<20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
	<20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, 14 Apr 2006 09:48:25 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:
> > +/* write protected page under migration*/
> > +#define SWP_TYPE_MIGRATION_WP	(MAX_SWAPFILES - 1)
> > +/* write enabled migration type */
> > +#define SWP_TYPE_MIGRATION_WE	(MAX_SWAPFILES)
> 
> Could we call this SWP_TYPE_MIGRATION_READ / WRITE?
> 
ok, it looks better.

> > +	pte = pte_mkold(mk_pte(new, vma->vm_page_prot));
> > +	if (is_migration_entry_we(entry)) {
> is_write_migration_entry?
> 
> > +		pte = pte_mkwrite(pte);
> > +	}
> 
> No {} needed.
> 
> > -			entry = make_migration_entry(page);
> > +			if (pte_write(pteval))
> > +				entry = make_migration_entry(page, 1);
> > +			else
> > +				entry = make_migration_entry(page, 0);
> >  		}
> 
> entry = make_migration_entry(page, pte_write(pteval))
> 
> ?
Ah, O.K.

Thanks,
-Kame


