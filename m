Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVDHQGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVDHQGj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVDHQGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:06:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29118 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262861AbVDHQGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:06:37 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Arjan van de Ven <arjan@infradead.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Mingming Cao <cmm@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 18:06:30 +0200
Message-Id: <1112976390.6278.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

>  And rw locking is much better for concurrency, so
> we might be able to hold it over the whole bitmap search rather than
> taking it and dropping it at each window advance.

rw locks only help if readers are 10x more common than writers generally
speaking. They are quite expensive locks, so they really should be used
with the utmost care. 
(if you have really long hold times the dynamics are different, but if
you have really long hold times your latency sucks too and wasn't that
what this thread was trying to fix?)

