Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281157AbRKOXHl>; Thu, 15 Nov 2001 18:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281159AbRKOXHb>; Thu, 15 Nov 2001 18:07:31 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:46745 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S281157AbRKOXHU> convert rfc822-to-8bit; Thu, 15 Nov 2001 18:07:20 -0500
Date: Thu, 15 Nov 2001 21:22:09 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Hugh Dickins <hugh@veritas.com>
Cc: "David S. Miller" <davem@redhat.com>, <anton@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] small sym-2 fix
In-Reply-To: <Pine.LNX.4.21.0111152105500.1588-100000@localhost.localdomain>
Message-ID: <20011115205859.B2340-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Nov 2001, Hugh Dickins wrote:

> On Thu, 15 Nov 2001, Gérard Roudier wrote:
> >
> > To be serious, the right fix is to have some logical page be some power of
> > two of the physical page when the physical page is too small. Can we hope
> > Linux-2.5 to allow this?
>
> It's certainly doable.  I have an i386 patch against 2.4.7 which did that,
> MMUPAGE_SIZE 4kB distinguished from PAGE_SIZE 4kB, 8kB, 16kB or 32kB
> (but 64kB truncates to 0 in unsigned short b_size, doesn't work so well!);
> while still presenting the 4kB EXEC_PAGESIZE to userspace.
>
> It's a bit tedious working through each kernel update, to decide which
> PAGEs should be MMUPAGEs etc, and I didn't see an immediate reward of
> a huge leap in performance, so I haven't kept it up to date since then.

Think about portable _software_ as large parts of the kernel that have to
cope with very different _hardware_ allocation granularities depending on
targetted platforms. This led and still leads to useless complexity in
many places. Apart this that will require to modify the kernel code in
order to gain full advantage of a new larger page size, you will get some
not negligible immediate reward on IA32, as for example fork() to be
really unlikely to fail on loaded machines, etc..., etc...

  Gérard.

