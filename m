Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287155AbSALQ2L>; Sat, 12 Jan 2002 11:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287158AbSALQ2C>; Sat, 12 Jan 2002 11:28:02 -0500
Received: from fungus.teststation.com ([212.32.186.211]:17676 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S287155AbSALQ1n>; Sat, 12 Jan 2002 11:27:43 -0500
Date: Sat, 12 Jan 2002 17:27:41 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: <linux-kernel@vger.kernel.org>
Subject: smbfs patches for 2.5
Message-ID: <Pine.LNX.4.33.0201121702540.5143-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello

I have put the patches I have for smbfs on:
	http://www.hojdpunkten.ac.se/054/samba/index.html

Features are:
Large File Support, Unicode, oplocks, fcntl locking, async requests.


If you are a smbfs user you may want to test this and tell me if I have
broken your favourite application. It helps if you are not afraid of
kernel bugs ...

This is not the versions I will send to Linus, they are not finished. It
is the code I am running myself though, and now that it is no longer quite
as toxic as it was perhaps someone else would like to test it too.


If you are the type of person that likes to read code, the part I would
like most to get feedback on is the async request code (the request.c and
smbiod.c parts are the new stuff in the "03" patch).

There are a lot of FIXMEs in this. I have tried to point out all the
places where I know I have done bad things and not yet fixed them.


A small test with 'dd' and the async request code gives me about 10% worse
performance with a single reader compared to the old code, and about 10%
better performace with 2 readers of different files. Readahead and
elimination of one extra full-page memcpy on each read should fix the
single reader drop, as well replacing the silly re-implementation of
'poll' (don't ask :)

/Urban

