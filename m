Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUFNO77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUFNO77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUFNO77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:59:59 -0400
Received: from zulo.virutass.net ([62.151.20.186]:39402 "EHLO
	mx.larebelion.net") by vger.kernel.org with ESMTP id S262389AbUFNO74 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:59:56 -0400
From: Manuel Arostegui Ramirez <manuel@todo-linux.com>
To: Nuno Monteiro <nuno@itsari.org>, Gianni Tedesco <gianni@scaramanga.co.uk>
Subject: Re: Local DoS attack on i386 (was: new kernel bug)
Date: Mon, 14 Jun 2004 16:59:37 +0200
User-Agent: KMail/1.5
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
References: <200406121159.28406.manuel@todo-linux.com> <1087221517.3375.3.camel@sherbert> <20040614142001.GA3032@hobbes.itsari.int>
In-Reply-To: <20040614142001.GA3032@hobbes.itsari.int>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406141659.37844.manuel@todo-linux.com>
X-Virus: by Larebelion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Lunes 14 Junio 2004 16:20, Nuno Monteiro escribió:
> On 2004.06.14 14:58, Gianni Tedesco wrote:
> > On Sat, 2004-06-12 at 11:59 +0200, Manuel Arostegui Ramirez wrote:
> > > Somebody know a patch to solved this new bug?
> > > http://reviewed.homelinux.org/news/2004-06-11_kernel_crash/index.html.e
> > >n Affected versions:
> > >     * Linux 2.6.x
> > >           o Linux 2.6.7-rc2
> > >           o Linux 2.6.6 (all versions)
> > >           o Linux 2.6.6 SMP (verified by riven)
> > >           o Linux 2.6.5-gentoo (verified by RatiX)
> > >           o Linux 2.6.5-mm6 - (verified by Mariux)
> > >     * Linux 2.4.2x
> > >           o Linux 2.4.26 vanilla
> > >           o Linux 2.4.26-rc1 vanilla
> > >           o Linux 2.4.26-gentoo-r1
> > >           o Linux 2.4.22
> >
> > Seems to be a scheduler race or something?
>
> This was already fixed in 2.6, see
> http://linux.bkbits.net:8080/linux-2.5/diffs/include/asm-i386/i387.h@1.16?n
>av=index.html|src/.|src/include|src/include/asm-i386|hist/include/asm-i386/i
>387.h
>
>
> The same fix should be applied to 2.4. I'm running locally a very
> hacked version of 2.4.22 with it and it survives that crash.c program.
>
> Here's the diff. Marcelo, please merge.
>
>
> ---
> linux-2.4.27-pre5/include/asm-i386/i387.h~fix-x86-clear_fpu-macro	2004-06-1
>4 15:12:13.909059344 +0100 +++
> linux-2.4.27-pre5/include/asm-i386/i387.h	2004-06-14 15:12:45.970185312
> +0100 @@ -34,7 +34,7 @@ extern void kernel_fpu_begin(void);
>
>  #define clear_fpu( tsk ) do { \
>  	if ( tsk->flags & PF_USEDFPU ) { \
> -		asm volatile("fwait"); \
> +		asm volatile("fnclex ; fwait"); \
>  		tsk->flags &= ~PF_USEDFPU; \
>  		stts(); \
>  	} \
> -

This diff fixed the bug in 2.4.X?
Thanks,  Nuno, I'm going to apply it.
Best Regards

-- 
Manuel Arostegui Ramirez #Linux Registered User 200896

