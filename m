Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVLUSGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVLUSGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVLUSGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:06:44 -0500
Received: from spirit.analogic.com ([204.178.40.4]:57613 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751152AbVLUSGn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:06:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
X-OriginalArrivalTime: 21 Dec 2005 18:06:42.0257 (UTC) FILETIME=[4BF0DC10:01C60659]
Content-class: urn:content-classes:message
Subject: Re: Question on the current behaviour of malloc () on Linux
Date: Wed, 21 Dec 2005 13:06:42 -0500
Message-ID: <Pine.LNX.4.61.0512211259090.12113@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on the current behaviour of malloc () on Linux
Thread-Index: AcYGWUwUSKDzzLFWQfCn0Z/Iokx+Qw==
References: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jie Zhang" <jzhang918@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>, <lars.friedrich@wago.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2005, Jie Zhang wrote:

> Hi,
>
> I first asked this question on uClinux mailing list. My first question
> is <http://mailman.uclinux.org/pipermail/uclinux-dev/2005-December/036042.html>.
> Although I found this issue on uClinux, it's also can be demostrated
> on Linux. This is a small program:
>

Another FAQ....

> $> cat test2.c
> #include <stdio.h>
> #include <stdlib.h>
>
> int
> main ()
> {
>  char *p;
>  int i, j;
>  for (i = 0;; i++)
>    {
>      p = (char *) malloc (8 * 1024 * 1024);
>      if (p)
>        for (j = 0; j < 8 * 1024 * 1024; j++)
>          p[j] = 0x55;
>      else
>        {
>          printf ("%d fail\n", i);
>          break;
>        }
>    }
>  return 0;
> }
>
> When I run it on my Linux notebook, it will be killed. I expect to see
> it prints out   "fail".

Your expectations are not based upon any logic, only wishes.

>
> Thanks,
> Jie
>


To make your wishes come true execute:
     echo "1" >/proc/sys/vm/overcommit_memory
... as a super-user.

That will make malloc() fail when there isn't any more virtual
memory.

An even shorter program...

main ()
{
     for(;;)
         *(long *)malloc(0x0010000) = 1;
}

This will seg-fault because malloc will eventually return NULL and,
yawn, nothing except your program gets killed.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
