Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129548AbQK0JMa>; Mon, 27 Nov 2000 04:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129735AbQK0JMV>; Mon, 27 Nov 2000 04:12:21 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:1810 "EHLO
        almesberger.net") by vger.kernel.org with ESMTP id <S129548AbQK0JMH>;
        Mon, 27 Nov 2000 04:12:07 -0500
Date: Mon, 27 Nov 2000 09:41:39 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001127094139.H599@almesberger.net>
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com>; from adam@yggdrasil.com on Sun, Nov 26, 2000 at 09:56:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> 	At the moment, I have started daydreaming about instead
> writing an "elf squeezer" to do this and other space optimizations
> by modifying objdump.

Hmm, this would require that gcc never calculates the location of an
explicitly initialized static variable based on the address of another
one. E.g. in

static int a = 0, b = 0, c = 0, d = 0;

...
    ... a+b+c+d ...
...

egcs-2.91.66 indeed doesn't seem to make this optimization on i386.
(Maybe the pointer increment or pointer offset solution would
actually be slower - didn't check.) But I'm not sure if this is also
true for other versions/architectures, or other code constructs.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
