Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbVLFLX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbVLFLX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVLFLX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:23:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:55238 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751385AbVLFLX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:23:27 -0500
From: "David Engraf" <engraf.david@netcom-sicherheitstechnik.de>
To: "'Arjan van de Ven'" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
Date: Tue, 6 Dec 2005 12:23:23 +0100
Message-ID: <000001c5fa57$797051b0$0a016696@EW10>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1133865880.2858.42.camel@laptopd505.fenrus.org>
Thread-Index: AcX6UtgdfEc1Jgq0T8+J4Y47+f1tzwAAS+wQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:79a9c929f10b28b00e544b1aedb42267
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2005-12-06 at 11:36 +0100, David Engraf wrote:
> > This patch adds a new systemcall on i386 architectures returning the
jiffies
> > value to the application. 
> > As a kernel developer you can use jiffies but from the user space there
is
> > no equivalent function which counts every millisecond like the Win32
> > GetTickCount.

> a few comments

> 1) jiffies are 64 bit not 32

Jiffies is defined as "unsigned long volatile __jiffy_data jiffies". On i386
machines unsigned long is 32.


> 2) jiffies are not a constant time, eg HZ is a config option,
>    exposing that internal counter to userspace sounds wrong, after
>    all what would it be used for

Right, HZ is defined as USER_HZ which can be set over the config. On normal
desktop systems it should be 1000 on other machines it could also be 100 or
250. Either we can ignore the setting and the function depends on the
USER_HZ config, or we have to calculate the right value with USER_HZ. 


> 3) wouldn't it be better to expose a wallclock time thing which
>    has a constant unit of time between all kernels?

What is it?


> (and.. wait.. isn't that called gettimeofday() )
Not really gettimeofday is based on the date and time, but what if the user
changes the date, the counter would also change.



____________
Virus checked by G DATA AntiVirusKit
Version: AVK 16.2038 from 06.12.2005
Virus news: www.antiviruslab.com

