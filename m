Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWGPAuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWGPAuv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 20:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWGPAuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 20:50:51 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:31699 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1946062AbWGPAuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 20:50:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G6P6ZjBQGfZxP96PUKbn3WAUXRUUuLDjx9Ge7nyF/eWfY02nkb0bs/3QNDEj639VsmhC0wcc0MVTNm0CBzgVkTRUjnVHcPJ4ePKZexy2KhTlRklV0MDvAmWomRWzxTHyOyYnCVDfFMG+3pxhOFDqh9JjnHLX2mJJa1lpQYLkYD8=
Message-ID: <6bffcb0e0607151750m313ee23ey6da10c700b1fc3ef@mail.gmail.com>
Date: Sun, 16 Jul 2006 02:50:49 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc1-mm2: process `showconsole' used the removed sysctl system call
Cc: "Andrew Morton" <akpm@osdl.org>, "Tilman Schmidt" <tilman@imap.cc>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1odvqpfg1.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44B8FE64.6040700@imap.cc> <20060715154200.e9138a6b.akpm@osdl.org>
	 <44B97ADD.5000302@gmail.com>
	 <m1odvqpfg1.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Michal Piotrowski <michal.k.k.piotrowski@gmail.com> writes:
>
> > Hi Andrew,
> >
> > Andrew Morton wrote:
> >> On Sat, 15 Jul 2006 16:40:36 +0200
> >> Tilman Schmidt <tilman@imap.cc> wrote:
> >>
> >>> After installing a 2.6.18-rc1-mm2 kernel without sysctl syscall support
> >>> on a standard SuSE 10.0 system, I find the following in my dmesg:
> >>>
> >>>> [ 36.955720] warning: process `showconsole' used the removed sysctl system
> > call
> >>>> [ 39.656410] warning: process `showconsole' used the removed sysctl system
> > call
> >>>> [ 43.304401] warning: process `showconsole' used the removed sysctl system
> > call
> >>>> [   45.717220] warning: process `ls' used the removed sysctl system call
> >>>> [   45.789845] warning: process `touch' used the removed sysctl system call
> >>> which at face value seems to contradict the statement in the help text
> >>> for the CONFIG_SYSCTL_SYSCALL option that "Nothing has been using the
> >>> binary sysctl interface for some time time now". (sic)
> >>>
> >>> Meanwhile, the second part of that sentence that "nothing should break"
> >>> by disabling it seems to hold true anyway. The system runs fine, and
> >>> activating CONFIG_SYSCTL_SYSCALL in the kernel doesn't seem to have any
> >>> effect apart from changing the word "removed" to "obsolete" in the above
> >>> messages.
> >>
> >> Thanks.
> >>
> >
> > date and salsa also use sysctl.
> >
> > warning: process `date' used the removed sysctl system call
> > warning: process `salsa' used the removed sysctl system call
> >
> >> Eric, that tends to make the whole idea inviable, doesn't it?
> >
> > How about _very_ long term to remove sysctl (i.e. January 2010)?
>
> That may be reasonable.  However please confirm that everything
> that you have complaints from is using libpthreads.

ldd /bin/date
        linux-gate.so.1 =>  (0xb7f22000)
        librt.so.1 => /lib/librt.so.1 (0x4aab9000)
        libc.so.6 => /lib/libc.so.6 (0x49ca3000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x49f38000)
        /lib/ld-linux.so.2 (0x49c86000)

ldd /bin/ls
        linux-gate.so.1 =>  (0xb7f23000)
        librt.so.1 => /lib/librt.so.1 (0x4aab9000)
        libselinux.so.1 => /lib/libselinux.so.1 (0x45a71000)
        libc.so.6 => /lib/libc.so.6 (0x49ca3000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x49f38000)
        /lib/ld-linux.so.2 (0x49c86000)
        libdl.so.2 => /lib/libdl.so.2 (0x49dd8000)
        libsepol.so.1 => /lib/libsepol.so.1 (0x41ad5000)

ldd /sbin/salsa
        linux-gate.so.1 =>  (0xb7fd7000)
        libasound.so.2 => /lib/libasound.so.2 (0x4100f000)
        libc.so.6 => /lib/libc.so.6 (0x49ca3000)
        libm.so.6 => /lib/libm.so.6 (0x49dde000)
        libdl.so.2 => /lib/libdl.so.2 (0x49dd8000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x49f38000)
        /lib/ld-linux.so.2 (0x49c86000)

ldd /bin/touch
        linux-gate.so.1 =>  (0xb7fa2000)
        librt.so.1 => /lib/librt.so.1 (0x4aab9000)
        libc.so.6 => /lib/libc.so.6 (0x49ca3000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x49f38000)
        /lib/ld-linux.so.2 (0x49c86000)

I can confirm this, but I don't have a "showconsole".

>
> As there is one use of libpthreads that is using sysctl
> in a very non-serious way.
>
> With libptrheads modified to use uname and not sysctl I am not seeing that
> message.  I thought I had broken my test setup by forgetting to compile
> glibc with --with-tls but I managed but I managed to get things working
> again using LD_ASSUME_KERNEL=2.4.1
>
> Still not the best data point but a very interesting one.
>
> Eric
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
