Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWGSRGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWGSRGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 13:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWGSRGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 13:06:53 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:56966 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030194AbWGSRGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 13:06:53 -0400
Date: Wed, 19 Jul 2006 13:02:29 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] x86: Don't randomize stack unless
  current->personality permits it
To: Al Boldi <a1426z@gawab.com>
Cc: Paulo Marques <pmarques@grupopie.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Frank van Maarseveen <frankvm@frankvm.com>
Message-ID: <200607191305_MC3-1-C56F-6E4F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200607180821.45346.a1426z@gawab.com>

On Tue, 18 Jul 2006 08:21:45 +0300. Al Boldi wrote:

> Going one step further,
> with #define arch_stack_align(x) (x)
> all blips/hits/weirdness are gone
> 
> Which means that either arch_stack_align isn't necessary at all, or 
> randomization isn't working as intended.
> 
> Can somebody prove me wrong here?

Your program seems highly sensitive to any changes, e.g. with the
following code, results with and without the commented lines are
different.  (I changed i to 5555555 because my cpu is slower than
yours and changed main() to call it 10 times.)  This on an AMD
Turion64 1.6GHz running an i386 kernel with stock arch_stack_align()
and randomize_va_space == 1.

void fn()
{
        double x = 0.0, y = 0.0;
        long i = 5555555;
//      static int printed = 0;
//
//      if (!printed) {
//              printed++;
//              printf("&x = %p, &y = %p\n", &x, &y);
//      }

        elapsed(1);
        while (i--)
                fn2(&x,&y);
        printf("%4lu ", elapsed(0));
}

$ ./tst.ex
&x = 0xbfb32d90, &y = 0xbfb32d98
  10    6   10   10    6   10    7   10   10   10   10   10   10   10   10   10   10   10   10   10 msec
$ ./tst.ex
   7   10    6    6    6    6   10   10    6    6    6   10   10    6    6    6    6   10    6    6 msec

BTW when compiled with gcc 4.1.1 using -O3 it just prints all zeros,
so I had to use 3.3.3.
-- 
Chuck
