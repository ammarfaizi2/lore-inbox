Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWFTAC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWFTAC6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 20:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWFTAC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 20:02:58 -0400
Received: from mailout1.pacific.net.au ([61.8.0.84]:2769 "EHLO
	mailout1.pacific.net.au") by vger.kernel.org with ESMTP
	id S964855AbWFTAC6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 20:02:58 -0400
User-Agent: Microsoft-Entourage/11.2.4.060510
Date: Tue, 20 Jun 2006 10:02:23 +1000
Subject: Re: emergency or init=/bin/sh mode and terminal signals
From: David Luyer <david@luyer.net>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: <linux-kernel@vger.kernel.org>
Message-ID: <C0BD782F.CF80%david@luyer.net>
Thread-Topic: emergency or init=/bin/sh mode and terminal signals
Thread-Index: AcaT/M5eDL/q3//wEdqThwAWy4r47g==
In-Reply-To: <20060619220920.GB5788@implementation.residence.ens-lyon.fr>
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/6/06 8:09 AM, "Samuel Thibault" <samuel.thibault@ens-lyon.org> wrote:
> linux-os (Dick Johnson), le Mon 19 Jun 2006 07:37:02 -0400, a écrit :
>> You can't allow some terminal input to affect init. It has been the
>> de facto standard in Unix, that the only time one should have a
>> controlling terminal is after somebody logs in and owns something to
>> control.
> 
> Ok. The following still makes sense, doesn't it? (i.e. set a session for
> the emergency shell)
> 
> --- linux-2.6.17-orig/init/main.c 2006-06-18 19:22:40.000000000 +0200
> +++ linux-2.6.17-perso/init/main.c 2006-06-20 00:07:07.000000000 +0200
> @@ -729,6 +729,11 @@
> run_init_process("/sbin/init");
> run_init_process("/etc/init");
> run_init_process("/bin/init");
> +
> + /* Set a session for the shell.  */
> + sys_setsid();
> + sys_ioctl(0, TIOCSCTTY, 1);
> +
> run_init_process("/bin/sh");
>  
> panic("No init found.  Try passing init= option to kernel.");

What if people are booting via /bin/sh and then setting up
their custom chroot's and init(s), and don't want these init(s) to
be part of a session?

It is also particularly possible for an embedded system to start
up via /bin/sh running /etc/profile rather than using an init type
program.

Also, the above doesn't help people specifying "init=/bin/sh" on the
command line (as per the original post subject).  The real solution
is for them to specify a different init= or run/exec something to set
up their tty and session once logged in.

David.


