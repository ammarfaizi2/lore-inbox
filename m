Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269452AbRHGVJu>; Tue, 7 Aug 2001 17:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269457AbRHGVJb>; Tue, 7 Aug 2001 17:09:31 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:28942 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S269452AbRHGVJZ>;
	Tue, 7 Aug 2001 17:09:25 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: encrypted swap
Date: 7 Aug 2001 21:06:10 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9kpl82$iao$1@abraham.cs.berkeley.edu>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C9A8@mail0.myrio.com> <Pine.LNX.4.33L2.0108072212590.18776-100000@spiral.extreme.ro>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 997218370 18776 128.32.45.153 (7 Aug 2001 21:06:10 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 7 Aug 2001 21:06:10 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Podeanu  wrote:
>If its going to be stolen while its offline, you
>can have your shutdown scripts blank the swap partition [...]

Erasing data, once written, is deceptively difficult.
See Peter Gutmann's excellent paper on the subject at
http://www.usenix.org/publications/library/proceedings/sec96/gutmann.html

It turns out that the easiest way to solve this problem is to make sure
you only ever write to the swap partition in encrypted form, and then when
you want to erase it securely, just throw away the key used to encrypt it.
(You have to securely erase this key, but it is much easier to erase
this key securely, because it is shorter and because you can arrange
that it only resides in RAM.)

It is critical that you choose a new encryption key each time you boot.
(Requiring users to enter in passphrases manually is unlikely to work well.)
