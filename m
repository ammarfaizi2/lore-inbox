Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262840AbVD2RKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbVD2RKC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVD2RKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:10:01 -0400
Received: from ns1.s2io.com ([142.46.200.198]:22469 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S262840AbVD2RJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:09:51 -0400
Subject: Re: tcp_sendpage and page allocation lifetime vs. iscsi
From: Dmitry Yusupov <dima@neterion.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Olivier Galibert <galibert@pobox.com>, avi@argo.co.il,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050425150840.5f27f77a.davem@davemloft.net>
References: <20050425170259.GA36024@dspnet.fr.eu.org>
	 <426D40D4.8050900@argo.co.il> <20050425121953.6b5c3278.davem@davemloft.net>
	 <20050425220603.GA64842@dspnet.fr.eu.org>
	 <20050425150840.5f27f77a.davem@davemloft.net>
Content-Type: text/plain
Organization: Neterion, Inc
Date: Fri, 29 Apr 2005 10:09:02 -0700
Message-Id: <1114794542.10446.8.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -102.5
X-Spam-Outlook-Score: ()
X-Spam-Features: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-25 at 15:08 -0700, David S. Miller wrote:
> On Tue, 26 Apr 2005 00:06:03 +0200
> Olivier Galibert <galibert@pobox.com> wrote:
> 
> > Do you think possible to extent the sendpage api to add some kind of
> > "don't get the pages, copy them if you need them" flag?
> 
> No, not really.
> 
> Do you happen to run the scsi->done() function from iscsi
> as soon as the write over the TCP socket completes returns
> success?  That is likely what is causing the problem.

Your guess is correct. If this happen Olivier will see corruption sooner
or later. But this should never happen, unless we have a subtle bug in
iscsi_tcp.c which needs to be verified and fixed.

Since SCSI tape device usually causing a lot of sense data, we probably
have a bug around sense data path processing. And this is not related to
TCP API abuse in anyway. I would recommend to continue this discussion
on www.open-iscsi.org mailing list.

Dima

