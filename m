Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161175AbWJKTnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbWJKTnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWJKTnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:43:37 -0400
Received: from terminus.zytor.com ([192.83.249.54]:34006 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161175AbWJKTng
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:43:36 -0400
Message-ID: <452D4947.80003@zytor.com>
Date: Wed, 11 Oct 2006 12:43:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alexander van Heukelum <heukelum@mailshack.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       John Coffman <johninsd@san.rr.com>
Subject: Re: [PATCH] Remove lilo-loads-only-five-sectors-of-zImage-fixup from
 setup.S
References: <20061011163356.GA2022@mailshack.com> <452D3A11.5020100@zytor.com> <20061011194301.GA2084@mailshack.com>
In-Reply-To: <20061011194301.GA2084@mailshack.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander van Heukelum wrote:
> 
> The patch should not alter behaviour for any bootloader that takes
> setupsects into account. It just removes 'support' for bootloaders that
> have the size of the setup code hardcoded to 4 sectors.
> 
> The current version of setup.S already checks if the bootloader
> understands boot protocol 2.00+ in the case of a big kernel, but that
> code is also after the 2k-mark. The zero-page still has some unused
> space between offsets 0x230 and 0x28f. Shall I put/move some code there
> to check unconditionally if the type_of_loader has been set?
> 
> I'll do that if no objections are put forward.
> 

The test can be done long before the zeropage is needed.  It should 
pretty much be done right away.

What I'm saying is that instead of pushing the initialization code 
downwards, the E820 & EDD space could overlay the code.  It would have 
been better, of course, if it was in a completely different chunk of the 
address space, but that's probably a much bigger change.

	-hpa
