Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270907AbTGPPL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270919AbTGPPL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:11:29 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:40843 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S270907AbTGPPL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:11:26 -0400
Date: Wed, 16 Jul 2003 16:25:32 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ron Niles <Ron.Niles@falconstor.com>, linux-kernel@vger.kernel.org
Subject: Re: Question about free_one_pgd() changes in these 3.5G patches
Message-ID: <20030716152532.GA18350@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Hugh Dickins <hugh@veritas.com>,
	Ron Niles <Ron.Niles@falconstor.com>, linux-kernel@vger.kernel.org
References: <E79B8AB303080F4096068F046CD1D89B01247A45@exchange1.FalconStor.Net> <Pine.LNX.4.44.0307161242280.1549-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307161242280.1549-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 01:31:39PM +0100, Hugh Dickins wrote:

Both this..

 > > 	for (j = 0; j < PTRS_PER_PMD ; j++) {
 > >  		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
 > > 		free_one_pmd(pmd+j);
 > > 	}

and this..

 > > 	pmd_t * pmd, * md, * emd;
 > > 	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
 > > 		prefetchw(md+(PREFETCH_STRIDE/16));
 > > 		free_one_pmd(md);
 > >  	}

both use the prefetch that was removed in 2.5 for 'being bogus'.
It can prefetch past the end iirc, which is fatal on some CPUs.

		Dave

