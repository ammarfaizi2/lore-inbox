Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVA0VDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVA0VDD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVA0VCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:02:00 -0500
Received: from canuck.infradead.org ([205.233.218.70]:59408 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261182AbVA0U45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:56:57 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <20050127204217.GA2481@infradead.org>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org> <20050127202335.GA2033@infradead.org>
	 <20050127202720.GA12390@infradead.org>
	 <20050127203206.GA2180@infradead.org>
	 <Pine.LNX.4.61.0501271539550.13927@chimarrao.boston.redhat.com>
	 <20050127204217.GA2481@infradead.org>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 21:56:49 +0100
Message-Id: <1106859409.5624.140.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 20:42 +0000, Christoph Hellwig wrote:
> On Thu, Jan 27, 2005 at 03:40:48PM -0500, Rik van Riel wrote:
> > On Thu, 27 Jan 2005, Christoph Hellwig wrote:
> > 
> > >>+unsigned long arch_align_stack(unsigned long sp)
> > >>+{
> > >>+	if (randomize_va_space)
> > >>+		sp -= ((get_random_int() % 4096) << 4);
> > >>+	return sp & ~0xf;
> > >>+}
> > >
> > >this looks like it'd work nicely on all architectures.
> > 
> > I guess it should work for all architectures using ELF,
> > not sure if it might break some of the more obscure
> > architectures ...
> 
> So it works for all CONFIG_MMU architectures.  Arjan mentioned that
> the minimum stack alignment might be different, so the 4 should
> become a per-arch constant and we can make the code unconditional
> for CONFIG_MMU?

and then there are architectures with an upward growing stack....
and maybe the alignment will even vary per cpu type (runtime) for some
architectures? Maybe arch maintainers can jump in quickly to say if a
scheme with a per arch shift factor would be sufficient or if all kinds
of horrors would creep up for them  (in which case a per arch function
would be more suitable)


