Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262232AbRETVd5>; Sun, 20 May 2001 17:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262234AbRETVdr>; Sun, 20 May 2001 17:33:47 -0400
Received: from mail.zmailer.org ([194.252.70.162]:39436 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S262232AbRETVdb>;
	Sun, 20 May 2001 17:33:31 -0400
Date: Mon, 21 May 2001 00:33:08 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Robert M. Love" <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sqrt in kernel?
Message-ID: <20010521003308.R5947@mea-ext.zmailer.org>
In-Reply-To: <990390802.1002.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <990390802.1002.0.camel@phantasy>; from rml@tech9.net on Sun, May 20, 2001 at 04:33:20PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 04:33:20PM -0400, Robert M. Love wrote:
> hi,
> 
> is there a sqrt function in the kernel? any other math functions?

	No.  (Assuming FP math sqrt function is your interest.)

	If you do scaled integers (fractions, with 2^n denominator),
	you can do newton iteration for sqrt nicely.

> i tried finding/grepping around, and found some various arch-specific
> stuff for fpu emulation... is there a general sqrt function?  is there a
> single file to look through with the various math functions?

	Yes.  Userspace.  ( <math.h> )

	As a rule:  NO FP MATH IS ALLOWED IN THE KERNEL!

	Now the question:  Why do you think you need FP math ?

	If your case is non-fast-path, you may do complete
	state save before, and restore after your FP code.


	In some cases even the fast-paths carry FP/MMX code,
	but those are cases where the save/restore overhead
	becomes negligible for all of the other processing
	that is going on.

> thanks,
> -- 
> Robert M. Love
> rml@ufl.edu
> rml@tech9.net

/Matti Aarnio
