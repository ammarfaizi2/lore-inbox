Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWDYUpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWDYUpA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWDYUpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:45:00 -0400
Received: from [198.99.130.12] ([198.99.130.12]:38837 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751325AbWDYUo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:44:59 -0400
Date: Tue, 25 Apr 2006 14:32:51 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060425183251.GB22977@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <20060420090514.GA9452@osiris.boeblingen.de.ibm.com> <444797F8.6020509@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444797F8.6020509@fujitsu-siemens.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 04:17:28PM +0200, Bodo Stroesser wrote:
> Shouldn't 'len' better be the number of bits in the mask than the number of 
> chars?

Yup.

> OTOH, I think UML shouldn't send the entire mask, but relevant part only. 
> The missing end is filled with 0xff by host anyway. So it would be
> enough to send the mask up to the highest bit representing a
> syscall, that needs to be executed by host.  (currently, that is
> __NR_gettimeofday). If UML would do so, no more problem results from
> UML having a higher NR_syscall than the host (as long as the new
> syscalls are to be intercepted and executed by UML)

Yup, that was part of the intent of sending in the mask length.

> A greater problem might be a process in UML, that calls an invalid syscall 
> number. AFAICS syscall number (orig_eax) isn't checked before it is
> used in do_syscall_trace to address syscall_mask. This might result
> in a crash. 

Yeah, this needs fixing.

				Heff
