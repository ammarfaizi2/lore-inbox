Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbULRSek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbULRSek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 13:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbULRSeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 13:34:36 -0500
Received: from canuck.infradead.org ([205.233.218.70]:51985 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261214AbULRSef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 13:34:35 -0500
Subject: Re: What does atomic_read actually do?
From: Arjan van de Ven <arjan@infradead.org>
To: Joseph Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <opsi7o5nqfs29e3l@grunion>
References: <opsi7o5nqfs29e3l@grunion>
Content-Type: text/plain
Date: Sat, 18 Dec 2004 19:34:27 +0100
Message-Id: <1103394867.4127.18.camel@laptopd505.fenrus.org>
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

On Sat, 2004-12-18 at 11:23 -0500, Joseph Seigh wrote:
> It doesn't do anything that would actually guarantee that the fetch from
> memory would be atomic as far as I can see, at least in the x86 version.

define atomic....

what linux atomics guarantee you is that you either "see" the old or the
new value if you use atomic_* as the sole accessor API, with the
footnote that this only holds if you don't forcefully misalign the
atomic_t.

if you want ordering guarantees on top... you need to use explicit
bariers for that (wmb/rmb and friends).

For the "no inbetween" rule, doing the read the way x86 does works on
x86, since x86 makes sure that on the write side, no intermediate
results become visible.


