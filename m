Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270278AbTGVNmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270630AbTGVNmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:42:33 -0400
Received: from h-64-236-243-31.twi.com ([64.236.243.31]:42602 "EHLO
	atwburmw02.twi.com") by vger.kernel.org with ESMTP id S270278AbTGVNmc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:42:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: vmalloc - kmalloc and page locks
Date: Tue, 22 Jul 2003 06:57:26 -0700
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: vmalloc - kmalloc and page locks
Thread-Index: AcNQUwJnnRJsjabgQYG66psKzZAgPgABVf8g
From: "Deas, Jim" <James.Deas@warnerbros.com>
To: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 22 Jul 2003 13:57:26.0424 (UTC)
 FILETIME=[2ED09980:01C35059]
X-WSS-ID: 13039D4C212371-01-02
Content-Type: text/plain;
 charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Message-Id: <S270278AbTGVNmc/20030722134232Z+5616@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the clarification. I am using mlockall on the user application. This 
still leaves me with the mystery of why my system usage goes from 3% to
50% randomly while playing data streams off the harddrive. I can also make
system usage stay at 50% by opening a third stream.
These streams are pulling data at 1.5MB/s each from different files (same HD).
I don't see that as a big strain on the hardware (4.5MB/s total data rate).
Where else should I look to find the bottleneck/latency issue?

Regards,
J. Deas


-----Original Message-----
From: Gábor Lénárt [mailto:lgb@lgb.hu]
Sent: Tuesday, July 22, 2003 6:13 AM
To: Deas, Jim
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmalloc - kmalloc and page locks


Errrrr ... Sorry, I did not read your mail carefully ;-(
I meant in case of a user process you can use mlock() and such :)
AFAIK the kernel itself is not pagable ...

On Tue, Jul 22, 2003 at 03:07:18PM +0200, Gábor Lénárt wrote:
> Please read something about the mlock() and/or mlockall() functions.
> The prototype can be found in [/usr/include/]sys/mman.h
> You can read there:
> 
> /* Guarantee all whole pages mapped by the range [ADDR,ADDR+LEN) to
>    be memory resident.  */
> extern int mlock (__const void *__addr, size_t __len) __THROW;
> [...]
> /* Cause all currently mapped pages of the process to be memory resident
>    until unlocked by a call to the `munlockall', until the process exits,
>    or until the process calls `execve'.  */
> extern int mlockall (int __flags) __THROW;
> 
> On Tue, Jul 22, 2003 at 06:00:14AM -0700, Deas, Jim wrote:
> > How can I look at what memory are being paged out of memory in the kernel
> > or how to lock kmalloc and vmalloc pages so they do not get put to swap?
> [...]
> 
> - Gábor (larta'H)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
- Gábor (larta'H)


