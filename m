Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVHLMtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVHLMtf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 08:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVHLMtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 08:49:35 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:60588 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751161AbVHLMte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 08:49:34 -0400
Subject: Re: [patch][-mm] selinux:  Reduce memory use by avtab
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050811203455.GA16409@mipter.zuzino.mipt.ru>
References: <1123788744.7810.115.camel@moss-spartans.epoch.ncsc.mil>
	 <20050811203455.GA16409@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 12 Aug 2005 08:47:20 -0400
Message-Id: <1123850840.23483.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-12 at 00:34 +0400, Alexey Dobriyan wrote:
> On Thu, Aug 11, 2005 at 03:32:24PM -0400, Stephen Smalley wrote:
> > This patch improves memory use by SELinux by both reducing the avtab
> > node size and reducing the number of avtab nodes.
> 
> > +int avtab_read_item(void *fp, u32 vers, struct avtab *a,
> > +	            int (*insertf)(struct avtab *a, struct avtab_key *k,
> > +				   struct avtab_datum *d, void *p),
> > +		    void *p)
> > +{
> > +	u16 buf16[4],
> 
> __le16
> 
> > +	u32 buf32[7],
> 
> __le32
> 
> > +		items2 = le32_to_cpu(buf32[0]);
> 
> > +	key.source_type = le16_to_cpu(buf16[items++]);
> 
> > +static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list, struct cond_av_list *other)
> > +{
> 
> > +	u32 buf[1]
> 
> __le32
> 
> > +	len = le32_to_cpu(buf[0]);
> 
> Stephen, "[PATCH] selinux: endian annotations" you ACKed in June is hopelessly
> lost or thoroughly queued for inclusion?

Hmmm...sorry about that - I do have that patch, but seem to have failed
to follow up on it.  I'll make a patch relative to this one that fixes
up any sparse bitwise warnings unless you have a particular desire to
update your original one.  Should -Wbitwise be included in CHECKFLAGS in
the kernel Makefile by default?

-- 
Stephen Smalley
National Security Agency

