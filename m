Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbRLFJzP>; Thu, 6 Dec 2001 04:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285092AbRLFJzG>; Thu, 6 Dec 2001 04:55:06 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:28938 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285089AbRLFJyu>;
	Thu, 6 Dec 2001 04:54:50 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16 for pointers to __devexit functions 
In-Reply-To: Your message of "Thu, 06 Dec 2001 03:09:46 CDT."
             <3C0F27CA.59C22DEF@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Dec 2001 20:54:37 +1100
Message-ID: <13818.1007632477@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2001 03:09:46 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>> This patch against 2.4.16 defines __devexit_p() for pointers to
>> functions defined as __devexit, the wrapper inserts the function name
>> or NULL, based on config options.  It allows people to use the new
>> binutils on the kernel, there are some real kernel bugs that binutils
>> will find once this patch is in.
>> 
>> I have patched all the obvious references to __devexit functions,
>> leaving a few which appear to be real bugs.  I notified the maintainers
>> of the buggy code privately.
>
>Why not __attribute__((weak)) ?

Because there are some real bugs in the kernel where code incorrectly
calls routines marked __devexit, a global conversion of __devexit
functions to NULL or weak will hide the bugs as well as the good code.
Most of the bugs are on error paths, typically an init routine calling
the exit code on error.  Changing to BUG() does not help either, that
only shows up the buggy code in the unlikely event of a device error.

Using __devexit_p() will automatically remove the references that
should not exist, the new binutils can then catch the other buggy code
at link time.

