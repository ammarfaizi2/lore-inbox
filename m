Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265839AbRGOD4o>; Sat, 14 Jul 2001 23:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbRGOD4d>; Sat, 14 Jul 2001 23:56:33 -0400
Received: from weta.f00f.org ([203.167.249.89]:45955 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S265839AbRGOD4Y>;
	Sat, 14 Jul 2001 23:56:24 -0400
Date: Sun, 15 Jul 2001 15:56:28 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@caldera.de>,
        Gunther Mayer <Gunther.Mayer@t-online.de>, paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
Message-ID: <20010715155628.F7624@weta.f00f.org>
In-Reply-To: <E15LTIY-0001Ul-00@the-village.bc.nu> <20010715154008.B7624@weta.f00f.org> <3B511226.B48B22F1@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B511226.B48B22F1@mandrakesoft.com>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 11:46:46PM -0400, Jeff Garzik wrote:

    1) this is the same fscking thing we have now with ifdef __KERNEL__

Except it is completely ignored by the preprocessor.

    2) if you are coming up with a -new- token, realize that
       kernel-private stuff is the common case, and use
       LIBC_KERNEL_SHARED_{BEGIN,END} instead

Sure, whatever works... the points I am trying to make are:

  * Don't pollute kernel headers with unnecessary pre-processor junk.

  * Give the LIBC people the power to choose which parts of the
    headers they ingore and otherwise.

  * Linus et al, can merge patches from LIBC people knowing they
    should only affect LIBC, not the kernel.


It doesn't matter what the token(s) is/are --- by making them comments
and invisible to the kernel is make life easier.

Also, if the LIBC people want something like:

        typedef unsigned int uint32_t;

then it could look like:

        /* LIBC_ONLY_BEGIN

        typedef unsigned int uint32_t;

        LIBC_ONLY_END */


or whatever. All the libc specific stuff hidden in comments, and
shared stuff indictaed by comments.  A simple script can then produce
LIBC suitable headers from the kernel ones.




  --cw


