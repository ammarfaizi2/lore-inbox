Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWEOP5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWEOP5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWEOP5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:57:45 -0400
Received: from test-iport-1.cisco.com ([171.71.176.117]:34632 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751588AbWEOP5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:57:43 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 53 of 53] ipath - add memory barrier when waiting for writes
X-Message-Flag: Warning: May contain useful information
References: <f8ebb8c1e43635081b73.1147477418@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 08:57:41 -0700
In-Reply-To: <f8ebb8c1e43635081b73.1147477418@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 12 May 2006 16:43:38 -0700")
Message-ID: <adazmhjth56.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 15:57:42.0371 (UTC) FILETIME=[4C81BB30:01C67838]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >  static void i2c_wait_for_writes(struct ipath_devdata *dd)
 >  {
 > +	mb();
 >  	(void)ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
 >  }

This needs a comment explaining why it's needed.  A memory barrier
before a readl() looks very strange since readl() should be ordered anyway.

 - R.
