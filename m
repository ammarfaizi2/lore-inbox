Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752069AbWCPKpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbWCPKpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbWCPKpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:45:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752069AbWCPKpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:45:16 -0500
Date: Thu, 16 Mar 2006 02:42:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-Id: <20060316024234.103d37dc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603161015130.31173@hermes-2.csi.cam.ac.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
	<Pine.LNX.4.64.0603161015130.31173@hermes-2.csi.cam.ac.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> > Various places are doing things like
>  > 
>  > typedef {
>  > 	FALSE,
>  > 	TRUE
>  > } my_fave_name_for_a_bool;
>  > 
>  > These are converted to
>  > 
>  > typedef int my_fave_name_for_a_bool;
> 
>  Given that the kernel now requires gcc 3.2 or later, that already includes 
>  a native boolean type (_Bool)?

It does?

Is it any good?

bix:/home/akpm> cat t.c
void foo()
{
	_Bool b = 1;

	b += 2;
}
bix:/home/akpm> gcc -O -Wall -c t.c
bix:/home/akpm> 

Sigh.

>  Why not use that instead of "int"?

That'd be a separate patch ;)

>  Also <stdbool.h> contains:
> 
>  #define bool	_Bool
>  #define true	1
>  #define false	0
> 
>  So we could take the bool rather than _Bool, too given _Bool looks 
>  rather ugly...

We have a couple of private bools and a couple of private 'true's and
`false's so I guess it'd be a simple patch.  I wonder if it would have any
surprising side-effects.

(I think using `bool' is a good thing - it makes the code more readable.
It's a shame the compiler's handling of it is so useless).

