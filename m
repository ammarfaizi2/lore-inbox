Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVA0Umm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVA0Umm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVA0Uml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:42:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50896 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261182AbVA0Um0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:42:26 -0500
Date: Thu, 27 Jan 2005 20:42:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rik van Riel <riel@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
Message-ID: <20050127204217.GA2481@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rik van Riel <riel@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org> <20050127202335.GA2033@infradead.org> <20050127202720.GA12390@infradead.org> <20050127203206.GA2180@infradead.org> <Pine.LNX.4.61.0501271539550.13927@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501271539550.13927@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 03:40:48PM -0500, Rik van Riel wrote:
> On Thu, 27 Jan 2005, Christoph Hellwig wrote:
> 
> >>+unsigned long arch_align_stack(unsigned long sp)
> >>+{
> >>+	if (randomize_va_space)
> >>+		sp -= ((get_random_int() % 4096) << 4);
> >>+	return sp & ~0xf;
> >>+}
> >
> >this looks like it'd work nicely on all architectures.
> 
> I guess it should work for all architectures using ELF,
> not sure if it might break some of the more obscure
> architectures ...

So it works for all CONFIG_MMU architectures.  Arjan mentioned that
the minimum stack alignment might be different, so the 4 should
become a per-arch constant and we can make the code unconditional
for CONFIG_MMU?
