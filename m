Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129689AbQJaGL1>; Tue, 31 Oct 2000 01:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129705AbQJaGLS>; Tue, 31 Oct 2000 01:11:18 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:26076 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129689AbQJaGLC>; Tue, 31 Oct 2000 01:11:02 -0500
Message-ID: <39FE6291.FA8162A7@didntduck.org>
Date: Tue, 31 Oct 2000 01:11:29 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kmalloc() allocation.
In-Reply-To: <E13qJZL-00076K-00@the-village.bc.nu> <Pine.LNX.3.95.1001030133720.3346A-100000@chaos.analogic.com> <8tll94$hc9$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Followup to:  <Pine.LNX.3.95.1001030133720.3346A-100000@chaos.analogic.com>
> By author:    "Richard B. Johnson" <root@chaos.analogic.com>
> In newsgroup: linux.dev.kernel
> >
> > > 64K probably less. kmalloc allocates physically linear spaces. vmalloc will
> > > happily grab you 2Mb of space but it will not be physically linear
> > >
> >
> > Okay. Thanks.
> >
> 
> FWIW, vmalloc()-allocated pages are definitely pinned-down and
> available to interrupts.  However, you should keep in mind that the
> vmalloc() call *itself* is quite expensive on SMP machines (have to
> interrupt all CPUs and flush their TLBs!!) so if you're using
> vmalloc(), be careful with the number of calls you make.  Of course,
> this is usually not a problem.

This was just changed in 2.4 so that vmalloced pages are faulted in on
demand.

--

					Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
