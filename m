Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUDFPxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263882AbUDFPxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:53:22 -0400
Received: from pop.gmx.de ([213.165.64.20]:15836 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263881AbUDFPxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:53:11 -0400
X-Authenticated: #271361
Date: Tue, 6 Apr 2004 17:53:01 +0200
From: Edgar Toernig <froese@gmx.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Catching SIGSEGV with signal() in 2.6
Message-Id: <20040406175301.1d46c0cd.froese@gmx.de>
In-Reply-To: <40722D42.90406@redhat.com>
References: <200404052040.54301.kevin.hendricks@sympatico.ca>
	<4072101F.3010603@redhat.com>
	<200404052301.28021.kevin.hendricks@sympatico.ca>
	<40722D42.90406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
>
> Kevin B. Hendricks wrote:
> 
> > So the code has been wrong since the beginning and we were just "lucky" it 
> > worked in all pre-2.6 kernels?
> 
> The old code depended on undefined behavior.

Maybe it's simply *old* code, possibly written under libc5.
There, signal() used SA_RESETHAND which implies SA_NODEFER
which in turn did not block the signal and exiting from the
signal handler via longjmp was OK.

With the new signal() behaviour in glibc2 one may get results
undefined by POSIX but it still worked as before because the
sigprocmask was ignored for SIGSEGV under Linux <2.6.

It's the combination of new glibc2 and new kernel that makes
code like the mentioned one break.

It has nothing to do with POSIX - for POSIX all of this is
"undefined/implementation defined behaviour".  I had chosen
to stay compatible...

Ciao, ET.

-- 
Not every program claims to be POSIX compliant (who reads
3600 pages of difficult to obtain specs?) - some are simply
Linux programs...
