Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280028AbRJ3Q5p>; Tue, 30 Oct 2001 11:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280025AbRJ3Q5a>; Tue, 30 Oct 2001 11:57:30 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:23779 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S280030AbRJ3Q5M>; Tue, 30 Oct 2001 11:57:12 -0500
Message-ID: <022401c16164$21a945d0$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.cdhetrv.1828dgd@ifi.uio.no> <fa.j17q3gv.m6e1ju@ifi.uio.no>
Subject: Re: SCSI tape crashes (was Re: BUG() in asm/pci.h:142 with 2.4.13)
Date: Tue, 30 Oct 2001 11:58:39 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can people try out this patch?  I believe this will fix the bug.
> + tb->sg[0].page = NULL;
>   if (tb->sg[segs].address == NULL) {

For the sake of making this clear to other kernel hackers (I got bitten by
it too) - starting with 2.4.13 you must zero out the fields of struct
scatterlist that you are not using. i.e. it is no longer sufficient to
simply set sg.address and sg.length, because junk might still be present in
the new sg.page field, and pci_map_*() will BUG() if both sg.address and
sg.page are non-zero.

Regards,
Dan


