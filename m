Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVLBWbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVLBWbr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVLBWbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:31:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:6637 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750773AbVLBWbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:31:46 -0500
Subject: Re: Better pagecache statistics ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-mm <linux-mm@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <y0md5kfxi15.fsf@tooth.toronto.redhat.com>
References: <1133377029.27824.90.camel@localhost.localdomain>
	 <20051201152029.GA14499@dmt.cnet>
	 <1133452790.27824.117.camel@localhost.localdomain>
	 <1133453411.2853.67.camel@laptopd505.fenrus.org>
	 <20051201170850.GA16235@dmt.cnet>
	 <1133457315.21429.29.camel@localhost.localdomain>
	 <1133457700.2853.78.camel@laptopd505.fenrus.org>
	 <20051201175711.GA17169@dmt.cnet>
	 <1133461212.21429.49.camel@localhost.localdomain>
	 <y0md5kfxi15.fsf@tooth.toronto.redhat.com>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 14:31:56 -0800
Message-Id: <1133562716.21429.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 17:15 -0500, Frank Ch. Eigler wrote:
> Badari Pulavarty <pbadari@us.ibm.com> writes:
> 
> > > Can't you add hooks to add_to_page_cache/remove_from_page_cache 
> > > to record pagecache activity ?
> > 
> > In theory, yes. We already maintain info in "mapping->nrpages".
> > Trick would be to collect all of them, send them to user space.
> 
> If you happened to have a copy of systemtap built, you might run this
> script instead of inserting static hooks into your kernel.  (The tool
> has come some way since the OLS '2005 demo.)
> 
> #! stap
> probe kernel.function("add_to_page_cache") {
>   printf("pid %d added pages (%d)\n", pid(), $mapping->nrpages)
> }
> probe kernel.function("__remove_from_page_cache") {
>   printf("pid %d removed pages (%d)\n", pid(), $page->mapping->nrpages)
> }

Yes. This is what I also did earlier to test. But unfortunately,
we need more than this.

Having by "pid" basis is not good enough. I need per file/mapping
basis collected and sent to user-space on-demand. Is systemtap
hooked to relayfs to send data across to user-land ? printf() is
not an option. And also, I need to have this probe, installed
from the boot time and collecting all the information - so I can
access it when I need it - which means this bloats kernel memory.
Isn't it ? 


Thanks,
Badari

