Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289776AbSBSULd>; Tue, 19 Feb 2002 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289377AbSBSUL1>; Tue, 19 Feb 2002 15:11:27 -0500
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:45443 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S289776AbSBSULO>; Tue, 19 Feb 2002 15:11:14 -0500
Message-ID: <0a5301c1b981$a921f820$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Jesse Barnes" <jbarnes@sgi.com>, "David Mosberger" <davidm@hpl.hp.com>
Cc: <linux-kernel@vger.kernel.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Ben Collins" <bcollins@debian.org>
In-Reply-To: <092401c1b8e7$1d190660$1a01a8c0@allyourbase> <15474.34580.625864.963930@napali.hpl.hp.com> <20020219103506.A1511175@sgi.com>
Subject: Re: readl/writel and memory barriers
Date: Tue, 19 Feb 2002 15:11:45 -0500
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

Jesse Barnes wrote:
> To avoid the overhead of having I/O flushed on every
> memory barrier and readX/writeX operation, we've introduced
> mmiob() on ia64, which explicity orders I/O space accesses.
> Some ports have chosen to take the performance hit in every
> readX/writeX, memory barrier, and spinlock however
> (e.g. PPC64, MIPS).

I have a hunch that many drivers will break if you change the semantics of
readX/writeX from in-order to out-of-order - lots of drivers are only
developed & tested on x86, which completely hides the issue...

If you consider the performance cost of in-order readX/writeX to be
significant, then I would suggest adding another group of readX/writeX APIs
that explicitly allow out-of-order PCI access. (__raw_readX/__raw_writeX
seem to offer this already on some platforms...)

Regards,
Dan

