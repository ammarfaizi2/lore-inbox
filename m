Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVAVWgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVAVWgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 17:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVAVWgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 17:36:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3249 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262761AbVAVWgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 17:36:09 -0500
Date: Sat, 22 Jan 2005 22:35:42 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Roland Dreier <roland@topspin.com>,
       Benjamin LaHaise <bcrl@kvack.org>, Alasdair G Kergon <agk@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: device-mapper: fix TB stripe data corruption
Message-ID: <20050122223542.GK14093@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
	Roland Dreier <roland@topspin.com>,
	Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
References: <20050121181203.GI10195@agk.surrey.redhat.com> <200501211512.45524.kevcorry@us.ibm.com> <52651qqy1s.fsf@topspin.com> <200501211557.38764.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501211557.38764.kevcorry@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 03:57:38PM -0600, Kevin Corry wrote:
> On Friday 21 January 2005 3:20 pm, Roland Dreier wrote:
> > If I understand you correctly, do_div() (defined in <asm/div64.h>)

I went for the simplest and safest fix first as this is a data
corruption problem and I want assurance that this fixes device-mapper
striping.

I didn't want to change it to do_div() without first checking
it would not slow down the code on the main architectures: on the contrary
I would hope that use of an optimised library inline speeds it up, but 
want to be sure.  You don't need the 64-bit mod until you have hundreds
of TB in a single logical volume block device, filesystem...

So far, I've only seen two test reports, both of which say they
are still seeing data corruption in a filesystem on top of dm-stripe
after applying this patch.  But none of this information so far
is specific enough to say whether the remaining problem(s) is/are
in device-mapper.

Alasdair
-- 
agk@redhat.com
