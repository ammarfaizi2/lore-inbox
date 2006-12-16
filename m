Return-Path: <linux-kernel-owner+w=401wt.eu-S965440AbWLPMET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965440AbWLPMET (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 07:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965438AbWLPMET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 07:04:19 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:60318 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965440AbWLPMES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 07:04:18 -0500
X-Originating-Ip: 24.148.236.183
Date: Sat, 16 Dec 2006 06:59:07 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Zach Brown <zach.brown@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <Pine.LNX.4.63.0612152351360.16895@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.64.0612160651140.3946@localhost.localdomain>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com>
 <Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
 <4581DAB0.2060505@s5r6.in-berlin.de> <Pine.LNX.4.61.0612151135330.22867@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612151547290.6136@localhost.localdomain>
 <Pine.LNX.4.63.0612152351360.16895@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006, Tim Schmielau wrote:

> On Fri, 15 Dec 2006, Robert P. J. Day wrote:
> > On Fri, 15 Dec 2006, Jan Engelhardt wrote:
> > > Even  sizeof a / sizeof *a
> > >
> > > may happen.
> >
> > yes, sadly, there are a number of those as well.  back to the drawing
> > board.
>
> It might be interesting to grep for anything that divides two
> sizeofs and eyeball the result for possible mistakes. This would
> provide some real benefit beyond the cosmetical changes.

i did that a while ago and it's amazing the variation that you find
beyond the obvious:

$ grep -Er "sizeof.*/.*sizeof" . | less

...
./net/key/af_key.c:     sa->sadb_sa_len = sizeof(struct sadb_sa)/sizeof(uint64_t);
./net/xfrm/xfrm_policy.c:       int len = sizeof(struct xfrm_selector) / sizeof(u32);
./net/core/flow.c:      const int n_elem = sizeof(struct flowi) / sizeof(flow_compare_t);
./net/ipv4/netfilter/arp_tables.c:      for (i = 0; i < sizeof(*arp)/sizeof(__u32); i++)
./net/ipv4/af_inet.c:#define INETSW_ARRAY_LEN (sizeof(inetsw_array) / sizeof(struct inet_protosw))
./drivers/net/wireless/ray_cs.c:        .num_standard   = sizeof(ray_handler)/sizeof(iw_handler),

and on and on.  there's no way a cute little perl script is
going to clean up all of *that*.

so what to do?

rday
