Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWCaXL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWCaXL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWCaXL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:11:56 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:44371 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750841AbWCaXL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:11:56 -0500
To: Shirley Ma <xma@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH] IPoIB queue size tune patch
X-Message-Flag: Warning: May contain useful information
References: <OFC9A94743.F4C78DFE-ON87257142.005F70AF-88257142.006068A0@us.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 31 Mar 2006 12:44:49 -0800
In-Reply-To: <OFC9A94743.F4C78DFE-ON87257142.005F70AF-88257142.006068A0@us.ibm.com> (Shirley Ma's message of "Fri, 31 Mar 2006 10:38:02 -0700")
Message-ID: <adaacb6z6m6.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 Mar 2006 20:44:51.0507 (UTC) FILETIME=[F5488030:01C65503]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +static int expsize(int size)
 > +{ 
 > +       int expsize_t = 1;
 > +       int j = 1;
 > +       while (size / 2 >= expsize_t) {
 > +               expsize_t = 1 << ++j;
 > +       }
 > +       return expsize_t;
 > +}

Yikes... is this just a very hard-to-understand version of roundup_pow_of_two()?

Hmm, no, it's rounding down I guess.  But is there any reason not to
use roundup_pow_of_two() instead?

 - R.
