Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWJLSf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWJLSf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWJLSf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:35:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56793 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750736AbWJLSf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:35:58 -0400
Date: Thu, 12 Oct 2006 19:35:29 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Heinz Mauelshagen <mauelshagen@redhat.com>
Subject: Re: dm stripe: Fix bounds
Message-ID: <20061012183529.GF17654@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Phillip Susi <psusi@cfl.rr.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Heinz Mauelshagen <mauelshagen@redhat.com>
References: <20060316151114.GS4724@agk.surrey.redhat.com> <452DBE11.2000005@cfl.rr.com> <20061012135945.GV17654@agk.surrey.redhat.com> <452E5FD0.8060309@cfl.rr.com> <20061012160515.GD17654@agk.surrey.redhat.com> <452E85ED.1040409@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452E85ED.1040409@cfl.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 02:14:05PM -0400, Phillip Susi wrote:
> So you are saying that dmraid should build 3 tables: 1 for the bulk of 
> the array, 1 for only the last stripe, and 1 linear to connect them?
 
No.  1 table.  2 consecutive targets with different stripe sizes, if that's
how the data is actually laid out.

> the only problem comes from the last 
> stripe.  How else could you map the last stripe other than laying down x 
> sectors onto y drives as x / y sectors on each drive in sequence?
 
Depends whether or not you give precedence to the stripe size.
The underlying device might be much larger - dm doesn't know or care - and
the intention of userspace might have been to truncate a larger striped
device part-way through one of the stripes - an equally reasonable thing to
do.

Alasdair
-- 
agk@redhat.com
