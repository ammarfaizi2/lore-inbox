Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131613AbQLLBhA>; Mon, 11 Dec 2000 20:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131615AbQLLBgu>; Mon, 11 Dec 2000 20:36:50 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:8216 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131613AbQLLBgi>;
	Mon, 11 Dec 2000 20:36:38 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: linux-2.4.0-test12pre8/include/linux/module.h breaks sysklogd compilation 
In-Reply-To: Your message of "Mon, 11 Dec 2000 14:59:01 -0800."
             <20001211145901.A8047@baldur.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Dec 2000 12:05:43 +1100
Message-ID: <3241.976583143@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000 14:59:01 -0800, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	linux-2.4.0test12pre8/include/linux/module.h contains some
>kernel-specific declarations that now reference struct list_head, which
>which is only defined when __KERNEL__ is set.  This causes sysklogd
>and probably any other user level program that needs to include
><linux/module.h> to fail to compile.
>
>	The following patch brackets the (unused) offending declarations
>in #ifdef __KERNEL__...#endif.

Linus, please do not apply.

User space applications _must_ not include kernel headers.  Even
modutils does not include linux/module.h, it has its own portable
(kernels 2.0 - 2.4) version.

I have strongly recommended to the sysklogd maintainers that they strip
all the symbol handling from klogd.  The oops decoding in klogd is
hopelessly out of date and broken.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
