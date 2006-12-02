Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162449AbWLBEAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162449AbWLBEAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162448AbWLBEAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:00:21 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:2575 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1162441AbWLBEAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:00:18 -0500
Date: Sat, 2 Dec 2006 14:59:58 +1100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Crypto Update for 2.6.20
Message-ID: <20061202035958.GA26690@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This is an update of the crypto tree for 2.6.20.  It contains
three new algorithms and one new hardware acceleration.  The
new algorithms are Camellia (an alternative encryption algorithm
to AES), XCBC-MAC (a MAC authentication based on encryption
algorithms), and LRW (a chain method for block encryption).  The
new AES acceleration is for the Geode LX.

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git

or

master.kernel.org:/pub/scm/linux/kernel/git/herbert/crypto-2.6.git


It contains the following changes:

Adrian Bunk:
      [CRYPTO] xcbc: Make needlessly global code static
      [CRYPTO] geode: Make needlessly global geode_aes_crypt() static
      [CRYPTO] api: Remove unused functions

Herbert Xu:
      [BLOCK] dm-crypt: Align IV to u64 for essiv
      [CRYPTO] camellia: Get setkey to use new calling convention
      [CRYPTO] cryptoloop: Select CRYPTO_CBC

Jordan Crouse:
      crypto:  Add support for the Geode LX AES hardware

Kazunori MIYAZAWA:
      [CRYPTO] xcbc: New algorithm
      [CRYPTO] tcrypt: Add test vectors of AES_XCBC
      [IPSEC]: Add support for AES-XCBC-MAC

Noriaki TAKAMIYA:
      [CRYPTO] camellia: Add Kconfig entry.
      [CRYPTO] camellia: added the code of Camellia cipher algorithm.
      [CRYPTO] camellia: added the testing code of Camellia cipher
      [IPSEC]: added the definition of Camellia cipher
      [IPSEC]: added the entry of Camellia cipher algorithm to ealg_list[]
      [CRYPTO] doc: added the developer of Camellia cipher

Rik Snel:
      [BLOCK] dm-crypt: benbi IV, big endian narrow block count for LRW-32-AES
      [CRYPTO] lib: some common 128-bit block operations, nicely centralized
      [CRYPTO] lib: table driven multiplications in GF(2^128)
      [CRYPTO] lrw: Liskov Rivest Wagner, a tweakable narrow block cipher mode
      [CRYPTO] tcrypt: LRW test vectors


 Documentation/crypto/api-intro.txt |    4 
 crypto/Kconfig                     |   49 +
 crypto/Makefile                    |    4 
 crypto/api.c                       |   15 
 crypto/camellia.c                  | 1801 +++++++++++++++++++++++++++++++++++++
 crypto/digest.c                    |   48 
 crypto/gf128mul.c                  |  466 +++++++++
 crypto/lrw.c                       |  301 ++++++
 crypto/tcrypt.c                    |   58 +
 crypto/tcrypt.h                    |  767 +++++++++++++++
 crypto/xcbc.c                      |  348 +++++++
 drivers/block/Kconfig              |    1 
 drivers/crypto/Kconfig             |   13 
 drivers/crypto/Makefile            |    1 
 drivers/crypto/geode-aes.c         |  474 +++++++++
 drivers/crypto/geode-aes.h         |   40 
 drivers/md/dm-crypt.c              |   53 +
 include/crypto/b128ops.h           |   80 +
 include/crypto/gf128mul.h          |  198 ++++
 include/linux/crypto.h             |   22 
 include/linux/pfkeyv2.h            |    2 
 net/xfrm/xfrm_algo.c               |   34 
 22 files changed, 4687 insertions(+), 92 deletions(-)
 
Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
