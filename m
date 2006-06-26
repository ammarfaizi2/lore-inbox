Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWFZHj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWFZHj4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 03:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWFZHj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 03:39:56 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:25097 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932302AbWFZHjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 03:39:55 -0400
Date: Mon, 26 Jun 2006 17:39:42 +1000
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Crypto Update for 2.6.17
Message-ID: <20060626073942.GA2811@gondor.apana.org.au>
References: <20060620101719.GA13625@gondor.apana.org.au> <20060623235551.GA6647@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623235551.GA6647@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This is a resend of a pull request for the crypto tree for 2.6.17.  Let
me know if there is anything you want me to fix up.  I've rebased it
against your latest git tree.

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git

or

master.kernel.org:/pub/scm/linux/kernel/git/herbert/crypto-2.6.git


It contains the following Crypto API changes which have been tested
in mm for a while now:

Atsushi Nemoto:
      [CRYPTO] khazad: Use 32-bit reads on key
      [CRYPTO] digest: Add alignment handling

Herbert Xu:
      [CRYPTO] aes-i586: Get rid of useless function wrappers
      [CRYPTO] digest: Remove unnecessary zeroing during init
      [CRYPTO] all: Pass tfm instead of ctx to algorithms
      [CRYPTO] padlock: Rearrange context structure to reduce code size
      [CRYPTO] api: Added cra_init/cra_exit
      [CRYPTO] api: Removed const from cra_name/cra_driver_name
      [CRYPTO] api: Allow replacement when registering new algorithms
      [CRYPTO] aes: Add wrappers for assembly routines
      [CRYPTO] tcrypt: Forbid tcrypt from being built-in

Michal Ludvig:
      [CRYPTO] api: Fixed incorrect passing of context instead of tfm
      [CRYPTO] tcrypt: Return -EAGAIN from module_init()
      [CRYPTO] tcrypt: Speed benchmark support for digest algorithms


 arch/i386/crypto/aes-i586-asm.S     |   29 ++---
 arch/i386/crypto/aes.c              |   20 ++--
 arch/i386/kernel/asm-offsets.c      |    3 
 arch/s390/crypto/aes_s390.c         |   14 +-
 arch/s390/crypto/des_s390.c         |   42 ++++----
 arch/s390/crypto/sha1_s390.c        |   34 +++---
 arch/s390/crypto/sha256_s390.c      |   14 +-
 arch/x86_64/crypto/aes-x86_64-asm.S |   22 ++--
 arch/x86_64/crypto/aes.c            |   20 +++-
 arch/x86_64/kernel/asm-offsets.c    |    3 
 crypto/Kconfig                      |    2 
 crypto/aes.c                        |   14 +-
 crypto/anubis.c                     |   13 +-
 crypto/api.c                        |   17 ++-
 crypto/arc4.c                       |    9 +
 crypto/blowfish.c                   |   19 ++-
 crypto/cast5.c                      |   14 +-
 crypto/cast6.c                      |   15 +--
 crypto/cipher.c                     |   14 +-
 crypto/compress.c                   |   15 ---
 crypto/crc32c.c                     |   19 ++-
 crypto/crypto_null.c                |   17 +--
 crypto/deflate.c                    |   23 ++--
 crypto/des.c                        |   27 +++--
 crypto/digest.c                     |   51 ++++++----
 crypto/khazad.c                     |   21 ++--
 crypto/md4.c                        |   12 +-
 crypto/md5.c                        |   12 +-
 crypto/michael_mic.c                |   20 ++--
 crypto/serpent.c                    |   27 +++--
 crypto/sha1.c                       |   18 ++-
 crypto/sha256.c                     |   19 ++-
 crypto/sha512.c                     |   29 ++---
 crypto/tcrypt.c                     |  179 +++++++++++++++++++++++++++++++++++-
 crypto/tcrypt.h                     |   36 +++++++
 crypto/tea.c                        |   55 +++++------
 crypto/tgr192.c                     |   33 +++---
 crypto/twofish.c                    |   14 +-
 crypto/wp512.c                      |   24 ++--
 drivers/crypto/padlock-aes.c        |   39 +++----
 include/linux/crypto.h              |   34 +++---
 41 files changed, 648 insertions(+), 394 deletions(-)

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
