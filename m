Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVLGQCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVLGQCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVLGQCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:02:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60896 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751147AbVLGQCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:02:48 -0500
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
	spin lock to atomic_t.
From: Arjan van de Ven <arjan@infradead.org>
To: Eduardo Pereira Habkost <ehabkost@mandriva.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051207160047.GG20451@duckman.conectiva>
References: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org>
	 <1133968943.2869.26.camel@laptopd505.fenrus.org>
	 <20051207160047.GG20451@duckman.conectiva>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 17:02:33 +0100
Message-Id: <1133971353.2869.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > No they're not. Both are just about equally expensive cpu wise,
> > sometimes the atomic_t ones are a bit more expensive (like on parisc
> > architecture). But on x86 in either case it's a locked cycle, which is
> > just expensive no matter which side you flip the coin... 
> 
> But if a lock is used exclusively to protect a int variable, an atomic_t
> seems to be more appropriate to me. Isn't it?

sounds like it... 

> Please, if you could, review the patches with this in mind: we aren't
> changing any behaviour neither creating any weird lock scheme, we are
> only doing two things:

... however you are NOT changing the behavior, which is EXACTLY my
point; the current "lock emulation" behavior is wrong, all you're doing
is replacing how you do the wrong thing ;)

It's like having a bike with square wheels, and replacing a flat tire
with one with air in, as opposed to replacing it with a round wheel...


