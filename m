Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263334AbRGEKVt>; Thu, 5 Jul 2001 06:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263318AbRGEKVk>; Thu, 5 Jul 2001 06:21:40 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:10376 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S263089AbRGEKVb>; Thu, 5 Jul 2001 06:21:31 -0400
Message-ID: <3B443F11.307A5F61@pp.inet.fi>
Date: Thu, 05 Jul 2001 13:18:57 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Swanson <swansma@yahoo.com>
CC: linux-kernel@vger.kernel.org, Stefan Traby <stefan@hello-penguin.com>
Subject: Re: loop device corruption in 2.4.6
In-Reply-To: <01070417140200.03178@test.home2.mark>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Swanson wrote:
> I get repeatable errors with 2.4.6 patched with the international encryption
> patch patch-int-2.4.3.1.bz2 when building loop device filesystems on top of
> Reiserfs.

International crypto patch assumes that block size never changes. Everyone
and their brother knows that it isn't true. And when block size does get
changed, international crypto patch gets the IV completely wrong, and
corrupts your data. To see block size changes in file systems alone, use
command something like this:

    grep set_blocksize `find /usr/src/linux-2.4.6/fs -name "*.c" -print`

And the block size thing is not the only thing wrong with international
crypto patch. The whole cryptoapi thing is just bloat that does not belong
in kernel. Cipher name string to number code mappings should be done in user
space instead of kernel. And the ice on the cake is that cryptoapi ciphers
are non-re-entrant and are actually used in re-entrant code path. This
non-re-entrant code in re-entrant code path is another source of data
corruption.

Loop-AES is a superior replacement for international crypto patch, for more
information about loop-AES, see this announcement:

    http://mail.nl.linux.org/linux-crypto/2001-06/msg00016.html
    http://lwn.net/2001/0628/a/file-crypto.php3

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
