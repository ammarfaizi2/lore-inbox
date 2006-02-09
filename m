Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422925AbWBIRhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422925AbWBIRhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422922AbWBIRhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:37:35 -0500
Received: from colin.muc.de ([193.149.48.1]:39179 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1422926AbWBIRhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:37:34 -0500
Date: 9 Feb 2006 18:37:26 +0100
Date: Thu, 9 Feb 2006 18:37:26 +0100
From: Andi Kleen <ak@muc.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Nathan Lynch <ntl@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Eric Dumazet <dada1@cosmosbay.com>, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       76306.1226@compuserve.com, wli@holomorphy.com,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060209173726.GA39278@muc.de>
References: <200602051959.k15JxoHK001630@hera.kernel.org> <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com> <20060208190512.5ebcdfbe.akpm@osdl.org> <20060208190839.63c57a96.akpm@osdl.org> <43EAC6BE.2060807@cosmosbay.com> <20060208204502.12513ae5.akpm@osdl.org> <20060209160808.GL18730@localhost.localdomain> <20060209161331.GE20554@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209161331.GE20554@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 05:13:31PM +0100, Heiko Carstens wrote:
> > > Presumably not all architectures are doing that.
> > powerpc/ppc64, for instance, determines the number of possible cpus
> > from information exported by firmware (and I'm mystified as to why
> > other platforms don't do this).  So it's typical to have a kernel an a
> > pSeries partition with NR_CPUS=128, but cpu_possible_map = 0xff.
> 
> Simply because there is no such interface on s390. The only thing we know
> for sure is that if we are running under z/VM the user is free to
> configure up to 63 additional virtual cpus on the fly...

x86-64 had the same problem, but we now require that you 
boot with additional_cpus=... for how many you want. Default is 0
(used to be half available CPUs but that lead to confusion)

Also the firmware has a way now to give this information automatically.

You can of course make it default to 64, but it will cost you 
several MB of memory in usually unused copies of per cpu data.

-Andi
