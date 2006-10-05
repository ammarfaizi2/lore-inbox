Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWJET5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWJET5S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWJET5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:57:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:49039 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751103AbWJET5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:57:16 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Joe Korty <joe.korty@ccur.com>,
       Inaky Perez-Gonzalez <inaky@linux.intel.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: separate bitmap parsing for user buffer and kernel buffer
References: <200610041756.30528.reinette.chatre@linux.intel.com>
	<20061004181003.6dae6065.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 05 Oct 2006 21:57:04 +0200
In-Reply-To: <20061004181003.6dae6065.akpm@osdl.org>
Message-ID: <p73odsqzgbz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 4 Oct 2006 17:56:30 -0700
> Reinette Chatre <reinette.chatre@linux.intel.com> wrote:
> 
> > +			if (is_user) {
> > +				if (__get_user(c, buf++))
> > +					return -EFAULT;
> > +			}
> > +			else
> > +				c = *buf++;
> 
> Is this actually needed?  __get_user(kernel_address) works OK and (believe
> it or not, given all the stuff it involves) boils down to a single instruction.		

It is needed on lots of architectures that use separate address spaces
like sparc64, m68k, s390 (and on x86 with 4:4 patches) 

-Andi
