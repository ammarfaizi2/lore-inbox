Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280035AbRJaCw5>; Tue, 30 Oct 2001 21:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280045AbRJaCws>; Tue, 30 Oct 2001 21:52:48 -0500
Received: from cr845378-a.rchrd1.on.wave.home.com ([24.157.76.7]:27472 "EHLO
	mielke.cc") by vger.kernel.org with ESMTP id <S280041AbRJaCwe>;
	Tue, 30 Oct 2001 21:52:34 -0500
Date: Tue, 30 Oct 2001 21:51:37 -0500 (EST)
From: Dave Mielke <dave@mielke.cc>
To: "Linux Kernel (mailing list)" <linux-kernel@vger.kernel.org>
Subject: Reading vcsa.
Message-ID: <Pine.LNX.4.30.0110302150310.1007-100000@dave.private.mielke.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I understood how characters are translated between the write()
system call and when they appear on the screen, but I've now come across an
example which doesn't fit. Can anyone please tell me where I'm wrong, or at
least point me to some documentation which explains this process more
accurately. My goal is to write as accurate as possible a reverse translation
process.

My current understanding is as follows: A character is first passed through
what we might call the host-to-unicode table, i.e. the one which is retrieved
by GIO_UNISCRNMAP. The resulting unicode value is then passed through what we
might call the unicode-to-font map, i.e. the one which is retrieved by
GIO_UNIMAP. If the intermediate unicode value is within the range F000-F0FF,
then the high-order F0 is zeroed, and the unicode-to-font table is bypassed.

While everything I've read so far seems to indicate that the fore-going is
correct, I must've missed something because I've encountered a system wherein
unicode-to-font translation (GIO_UNIMAP) is taking place even though all of the
host values 00-FF are being translated (GIO_UNISCRNMAP) to their respective
F000-F0FF unicode values. Is there another flag or state indicator I should be
checking? Is there another translation table I should be considering? In case
it matters, the system on which I've encountered this situation is running a
2.4.8 kernel.

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.

