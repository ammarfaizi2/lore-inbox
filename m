Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935224AbWKZBRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935224AbWKZBRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 20:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935221AbWKZBRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 20:17:12 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:49453 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S935224AbWKZBRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 20:17:10 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       tom@opengridcomputing.com
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
X-Message-Flag: Warning: May contain useful information
References: <adazmag5bk1.fsf@cisco.com>
	<20061124.220746.57445336.davem@davemloft.net>
	<adaodqv5e5l.fsf@cisco.com>
	<20061125.150500.14841768.davem@davemloft.net>
	<20061126011014.GR3078@ftp.linux.org.uk>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 25 Nov 2006 17:17:08 -0800
In-Reply-To: <20061126011014.GR3078@ftp.linux.org.uk> (Al Viro's message of "Sun, 26 Nov 2006 01:10:14 +0000")
Message-ID: <adaslg73t2j.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Nov 2006 01:17:08.0846 (UTC) FILETIME=[97D2D8E0:01C710F8]
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > 	(typeof(x))((x + a - 1) & ~(a - 1ULL))

Yes I was being stupid thinking I needed a temporary variable to use
typeof.  But what does the cast to typeof(x) accomplish if we write
things the way you suggested above?  It seems that the right things is
really just

	(((x) + (a) - 1) & ~((typeof(x)) (a) - 1))

 - R.
