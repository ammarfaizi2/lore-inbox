Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262900AbTCKL0E>; Tue, 11 Mar 2003 06:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbTCKL0E>; Tue, 11 Mar 2003 06:26:04 -0500
Received: from [80.190.48.67] ([80.190.48.67]:30724 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S262900AbTCKL0E> convert rfc822-to-8bit; Tue, 11 Mar 2003 06:26:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Torsten Foertsch <torsten.foertsch@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsscanf do not convert hex numbers starting with a non-digit
Date: Tue, 11 Mar 2003 12:36:15 +0100
User-Agent: KMail/1.4.3
References: <200303111202.19984.torsten.foertsch@gmx.net>
In-Reply-To: <200303111202.19984.torsten.foertsch@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303111236.15944.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 March 2003 12:02, Torsten Foertsch wrote:

Hi Torsten,


> I found the following little bug in 2.4.19. I did not try newer kernels.
> vsscanf refuses to convert a hex number starting with a nondecimal digit
> like:
> char *buf="ff";
> unsigned ff=0;
> sscanf( buf, "%x", &ff );      /* fails: nothing is converted */
>
> Here is a patch that corrects that behaviour:
>
> --- linux/lib/vsprintf.c        2001-10-11 20:17:22.000000000 +0200
> +++ linux.patched/lib/vsprintf.c        2003-03-11 11:52:08.000000000 +0100
> @@ -637,7 +637,7 @@
>                 while (isspace(*str))
>                         str++;
>
> -               if (!*str || !isdigit(*str))
> +               if (!*str || !(isdigit(*str) || (base==16 &&
> isxdigit(*str)))) break;
>
>                 switch(qualifier) {

http://marc.theaimsgroup.com/?l=linux-kernel&m=104687957102846&w=2

This fix was first posted since early 2.4.18-pre stage.

ciao, Marc


