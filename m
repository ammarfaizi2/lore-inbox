Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVCISUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVCISUD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVCISUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:20:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51586 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262045AbVCISTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:19:43 -0500
Subject: RE: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new mod
	ule  for LSI Logic's SAS based MegaRAID controllers
From: Arjan van de Ven <arjan@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CC20@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570230CC20@exa-atlanta>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 19:19:35 +0100
Message-Id: <1110392376.6280.139.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 12:44 -0500, Bagalkote, Sreenivas wrote:
> >> >
> >> >> . And since this is compile time
> >> >> system-wide property, I kept it as driver global.
> >> >
> >> >that step I don't understand... why is it a global 
> >*VARIABLE* if it's
> >> >compile time system-wide property...
> >> >
> >> 
> >> I see your point! Are you saying I should use 
> >if(sizeof(dma_addr_t)==8)
> >> instead of the shortcut if(is_dma64)? 
> >yep
> >well you can use a preprocessor define of something to make it slightly
> >more readable (eg shortcut) if you want, but that's what I mean yeah..
> >
> >gcc will optimize the entire unused code away this way, including the
> >actual conditional jump, so for performance and bloat-ness 
> >point of view
> >it's nice.... and of course generic design beauty ;)
> >
> 
> Great. Thanks! I will change it. If I understand you correctly, I should
> #define IS_DMA64 (sizeof(dma_addr_t)==8).

that's one way to do it yeah.
> 
> Is this better than declaring is_dma64 global variable const? (Excuse the
> oxymoron).

in C yes; in C "const" doesn't quite mean what you want it to mean with
this and as a result gcc I think can't optimize this the way it can with
the define.


