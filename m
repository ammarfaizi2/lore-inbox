Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVDDKqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVDDKqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 06:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVDDKqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 06:46:05 -0400
Received: from pD9F8754D.dip0.t-ipconnect.de ([217.248.117.77]:22146 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S261212AbVDDKqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 06:46:00 -0400
Message-ID: <42511AE5.1060603@pD9F8754D.dip0.t-ipconnect.de>
Date: Mon, 04 Apr 2005 12:45:57 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.6) Gecko/20050311
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: crypting filesystems
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to crypt some filesystems (/var, /home, /Data). I'm running LVM I
on all these partitions yet.

I searched, how to do this with linux and found 3 ways to achieve, what I
want to do.

1. crypto-loop (with kernel 2.6)
2. loop-AES (with kernel 2.2.x, 2.4.x and 2.6.x)
3. dm-crypt (with kernel 2.6.x)

Because I'm new to filesystem encryption, I searched for documentation of
all of these solutions and found, that crypto-loop seems not to be
maintained any more. loop-AES and dm-crypt remained. dm-crypt uses the
device mapper concept, which I know long ago from LVM and which therefore
seems to be the most logical solution to me. There is no need to patch the
mount-utility and integration is "out of the box".

So, I suggested to use dm-crypt with 2.6.11.6. I built 3 partitions with
cryptsetup (LUKS) with ESSIV-cipher and 256Bit keys on top of LVM 1 and
reiserfs as filesystem. The swap-partition is crypted with a random key,
which is generated each time at booting.

After all, there are remaining some questions open concerning the security
 / stability of this solution.

1. In order to put in the passphrase just once a time at booting, I put
the passphrase in a gpg-crypted file (cipher AES256 and 256Bit key size),
which is decrypted at boot-time to /tmp (-> tmpfs) and immediately removed
with shred, after activating the three partitions. Is it possible to see
the cleartext password after this action in tmpfs?

2. Is it possible to gain the passphrase from the active encrypted
partitions (because the passphrase is somewhere held in the RAM)?

3. I read at clemens.endorphin.org about 4 different cipher modes (CBC,
CMC, EME and LRW). Actually implemented in dm-crypt is the public-IV
on-disk format or ESSIV, both using CBC cipher mode. The other cipher
modes (CMC, EWE, LRW) are not implemented yet although they promise more
security.

My question is:
Was anybody able to decrypt one of these two implemented public-IV on-disk
formats, or, to say it in other words: are the known problems a mainly
theoretical discussion until today?

4. Are there any master keys existing, which could be used to open every
encrypted filesystem?

5. I read about problems (corrupted filesystem) with reiserfs (I'm using V
3.6). Are they fixed in 2.6.11.6? Would it be better to use XFS?



I would be very glad, if somebody could give me some advice.


Kind regards,
Andreas Hartmann
