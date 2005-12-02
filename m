Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbVLBWQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVLBWQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVLBWQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:16:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1718 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750911AbVLBWQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:16:14 -0500
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-mm <linux-mm@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Better pagecache statistics ?
References: <1133377029.27824.90.camel@localhost.localdomain>
	<20051201152029.GA14499@dmt.cnet>
	<1133452790.27824.117.camel@localhost.localdomain>
	<1133453411.2853.67.camel@laptopd505.fenrus.org>
	<20051201170850.GA16235@dmt.cnet>
	<1133457315.21429.29.camel@localhost.localdomain>
	<1133457700.2853.78.camel@laptopd505.fenrus.org>
	<20051201175711.GA17169@dmt.cnet>
	<1133461212.21429.49.camel@localhost.localdomain>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 02 Dec 2005 17:15:18 -0500
In-Reply-To: <1133461212.21429.49.camel@localhost.localdomain>
Message-ID: <y0md5kfxi15.fsf@tooth.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Badari Pulavarty <pbadari@us.ibm.com> writes:

> > Can't you add hooks to add_to_page_cache/remove_from_page_cache 
> > to record pagecache activity ?
> 
> In theory, yes. We already maintain info in "mapping->nrpages".
> Trick would be to collect all of them, send them to user space.

If you happened to have a copy of systemtap built, you might run this
script instead of inserting static hooks into your kernel.  (The tool
has come some way since the OLS '2005 demo.)

#! stap
probe kernel.function("add_to_page_cache") {
  printf("pid %d added pages (%d)\n", pid(), $mapping->nrpages)
}
probe kernel.function("__remove_from_page_cache") {
  printf("pid %d removed pages (%d)\n", pid(), $page->mapping->nrpages)
}

- FChE
