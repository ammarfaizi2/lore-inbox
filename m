Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132327AbRDFT3v>; Fri, 6 Apr 2001 15:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132338AbRDFT3l>; Fri, 6 Apr 2001 15:29:41 -0400
Received: from [195.55.70.99] ([195.55.70.99]:50696 "EHLO mozart")
	by vger.kernel.org with ESMTP id <S132328AbRDFT3c>;
	Fri, 6 Apr 2001 15:29:32 -0400
Message-Id: <m14lbxT-001PHvC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] __init functions called by non-__init 
In-Reply-To: Your message of "Wed, 04 Apr 2001 23:49:48 MST."
             <200104050649.XAA22384@csl.Stanford.EDU> 
Date: Sat, 07 Apr 2001 05:31:43 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200104050649.XAA22384@csl.Stanford.EDU> you write:
> where if you look in the code, the flagged routine generic_NCR53C400A_setup 
> does indeed not have __init:
> 	void generic_NCR53C400A_setup (char *str, int *ints) {
>     		internal_setup (BOARD_NCR53C400A, str, ints);
> 	}

As long as, of course, making that function an __init would not make
it a class 2 error.

> void __init uninit_aedsp16(void)
> 
> static void __exit cleanup_aedsp16(void) {
>         uninit_aedsp16();
> }

Ick.  Currently, this will work, since if it's not a module, __exit
function never get included or called.  If it is a module, __init does
nothing.

It's incredibly poor taste, though, and if we ever implement __init
dropping for modules (Keith?), it'll break horribly of course.  Thus
it's a bug to call __init functions from __exit functions, but not a
very exciting one.

Rusty.
--
Premature optmztion is rt of all evl. --DK
