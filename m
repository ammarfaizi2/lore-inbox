Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131671AbQKWL7l>; Thu, 23 Nov 2000 06:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131699AbQKWL7b>; Thu, 23 Nov 2000 06:59:31 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:59918 "EHLO
        almesberger.net") by vger.kernel.org with ESMTP id <S131671AbQKWL7L>;
        Thu, 23 Nov 2000 06:59:11 -0500
Date: Thu, 23 Nov 2000 12:28:37 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
Message-ID: <20001123122837.E599@almesberger.net>
In-Reply-To: <Pine.LNX.4.21.0011221031340.995-100000@panoramix.bitwizard.nl> <20001122092356.B53983@sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001122092356.B53983@sfgoth.com>; from mitch@sfgoth.com on Wed, Nov 22, 2000 at 09:23:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
>   * I don't like header files that define the registers of the chip - since
>     the header file is only included in the driver's .c

For a non-hypothetical case why it makes sense to have such things in
their own header file: if you dig out some older versions of the ATM
distribution, you'll find the programs called endump.c and zndump.c in
atm/debug. They run in user space and dump the card status, decoding
the "interesting" bits. And, of course, they include the register
headers.

Since they're strictly for development, it's okay that they include
things from deep down in /usr/src/linux (i.e. no need to move the
headers to linux/include/*), but it's important that they can share
the same definitions (to avoid version conflicts, etc.).

Besides, using a specific header file for the registers lowers the
risk that definitions get scattered all over the driver, so it makes
it easier to look for copy-from-manual bugs.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
