Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVKGOU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVKGOU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVKGOU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:20:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54685 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964825AbVKGOU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:20:59 -0500
Subject: Re: [patch 02/02] Debug option to write-protect rodata: the write
	protect logic and config option
From: Arjan van de Ven <arjan@infradead.org>
To: Josh Boyer <jdub@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
In-Reply-To: <1131372374.23658.1.camel@windu.rchland.ibm.com>
References: <20051107105624.GA6531@infradead.org>
	 <20051107105807.GB6531@infradead.org>
	 <1131372374.23658.1.camel@windu.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 15:20:48 +0100
Message-Id: <1131373248.2858.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 08:06 -0600, Josh Boyer wrote:
> On Mon, 2005-11-07 at 10:58 +0000, arjan@infradead.org wrote:
> > Hi,
> > 
> > I've been working on a patch that turns the kernel's .rodata section to be
> > actually read only, eg any write attempts to it cause a segmentation fault.
> > 
> > This patch introduces the actual debug option to catch any writes to rodata
> 
> Why a debug option?  From what I can tell, it doesn't impact runtime
> performance much and it provides good protection.  Any reason not to
> make it an always-on feature?

personally I'd like that but there is a chance of a tiny perf regression
and usually there are people objecting to that.

(It's not clear cut: while the last bit of the kernel no longer is
covered by a 2Mb tlb, most intel cpus have very few of such tlbs in the
first place and this would free up one such tlb for other things (say
the stack data) or even the userspace database), so it's not all that
clear cut what the cost of this is)


