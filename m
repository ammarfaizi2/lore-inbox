Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284263AbRLXASe>; Sun, 23 Dec 2001 19:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284272AbRLXASY>; Sun, 23 Dec 2001 19:18:24 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:5644 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284263AbRLXASO>; Sun, 23 Dec 2001 19:18:14 -0500
Message-ID: <3C2673B3.78E21527@zip.com.au>
Date: Sun, 23 Dec 2001 16:15:47 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: How to fix false positives on references to discarded text/data?
In-Reply-To: <Pine.LNX.4.33.0112232255500.1676-100000@vaio> <Pine.LNX.4.33.0112232343180.1676-100000@vaio>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> 
>         asm volatile(LOCK "subl $1,(%0)\n\t" \
>                      "js 2f\n" \
>                      "1:\n" \
> -                    ".section .text.lock,\"ax\"\n" \
> +                    ".subsection 1\n" \
>                      "2:\tcall " helper "\n\t" \
>                      "jmp 1b\n" \
>                      ".previous" \

Don't we want `.subsection 0' here, rather than .previous?

Apart from that, it looks like a winner.

-
