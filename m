Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWILWDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWILWDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWILWDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:03:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:53752 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030355AbWILWDs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:03:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: OT: calling kernel syscall manually
Date: Wed, 13 Sep 2006 00:03:12 +0200
User-Agent: KMail/1.9.1
Cc: David Woodhouse <dwmw2@infradead.org>, guest01 <guest01@gmail.com>,
       linux-kernel@vger.kernel.org
References: <4506A295.6010206@gmail.com> <1158068045.9189.93.camel@hades.cambridge.redhat.com> <450717A5.90509@cfl.rr.com>
In-Reply-To: <450717A5.90509@cfl.rr.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609130003.12789.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 September 2006 22:25, Phillip Susi wrote:
> 
> What do you mean you have removed the ability to make system calls 
> directly?  That makes no sense.  Glibc has to be able to make system 
> calls so you can write your own code that does the same thing if you want.

the header file <asm/unistd.h> that used to provide the necessary _syscallX()
macros doesn't do that any more. You can still use your own copy of the
macros though, like every libc does internally.

> For the OP: you might want to study the glibc sources to see how it 
> implements syscall, and mimic that.  IIRC it involves making an int 80 
> call on i386.
> 

char *pathname = "/tmp/dir";
int mode = 0644;
int result;
__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; int $0x80 ; pop %%ebx"
	: "=a" (result) 
	: "0" (__NR_mkdir),"ri" (pathname),"c" (mode)
	: "memory");

Understanding that inline assembly in detail is beyond what most people
do at university, but interesting nonetheless.

	Arnd <><
