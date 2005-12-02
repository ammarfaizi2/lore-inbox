Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbVLBIEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVLBIEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 03:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbVLBIEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 03:04:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48273 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750912AbVLBIEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 03:04:32 -0500
Subject: Re: [BUG] Variable stopmachine_state should be volatile
From: Arjan van de Ven <arjan@infradead.org>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E84040B3069@pdsmsx404>
References: <8126E4F969BA254AB43EA03C59F44E84040B3069@pdsmsx404>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 09:04:26 +0100
Message-Id: <1133510666.16520.3.camel@laptopd505.fenrus.org>
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

On Wed, 2005-11-30 at 10:04 +0800, Zhang, Yanmin wrote:
> The model to access variable stopmachine_state is that a main thread
> writes it and other threads read it. Its declaration has no sign
> volatile. In the while loop in function stopmachine, this variable is
> read, and compiler might optimize it by reading it once before the loop
> and not reading it again in the loop, so the thread might enter dead
> loop.

cpu_relax() includes a compiler barier..... so... what's wrong with the
compiler that it ignores such barriers?


