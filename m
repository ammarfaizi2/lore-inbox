Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271792AbRHRHij>; Sat, 18 Aug 2001 03:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271793AbRHRHi3>; Sat, 18 Aug 2001 03:38:29 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:16533 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S271792AbRHRHiR>; Sat, 18 Aug 2001 03:38:17 -0400
Date: Sat, 18 Aug 2001 10:38:42 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: <makisara@kai.makisara.local>
To: "(Martin Jacobs)" <100.179370@germanynet.de>
cc: <linux-kernel@vger.kernel.org>,
        Albrecht Jacobs <albrecht.jacobs@janglednerves.com>
Subject: Re: Q: 2.4.[37]-XFS: /dev/nst0m: cannot allocate memory
In-Reply-To: <Pine.LNX.4.33.0108172200330.17813-100000@Schnecke.Windsbach.de>
Message-ID: <Pine.LNX.4.33.0108181033140.12556-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, (Martin Jacobs) wrote:

> Hi all,
>
> I cannot read anything from my tape (Tandberg DLT8000, LVD
> interface, ID=5) connected to an aic7899 or an sym53c895 using
> kernel 2.4.3-XFS or 2.4.7-XFS. (Everything works fine on
> 2.2.16.) Loading of st.o works. stinit works. mt (status, tape
> positioning) works. But when I try to read the amanda header
> from the tape (dd if=/dev/nst0m bs=32k count=1) I get the
> error
>
> dd: reading `/dev/nst0m': Cannot allocate memory
>
...
> Nearly the same for tar (with default block size of 512 byte).
>
> BUT: if I use bs=64k it works!!?
>
In variable block mode in 2.4, you get ENOMEM if the block on the tape is
larger than the byte count in the read(). 2.2 just returned what you asked
for and silentlry threw away the rest of the block. If the byte count is
larger than the block size, then the block is returned.

I.e., the first block on your tape is larger than 32 kB.

	Kai


