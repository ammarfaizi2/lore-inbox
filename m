Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWIUB6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWIUB6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWIUB6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:58:44 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:28691 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750986AbWIUB6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:58:44 -0400
Date: Thu, 21 Sep 2006 11:57:47 +1000
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Crypto Update for 2.6.19
Message-ID: <20060921015747.GA15447@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

This is an update of the crypto tree for 2.6.19.  It contains
infrastructure changes for encryption and hashing.  These are
needed for better support of hardware crypto.  There are also
some driver/algorithm updates.

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git

or

master.kernel.org:/pub/scm/linux/kernel/git/herbert/crypto-2.6.git


It contains the following changes:

Adrian Bunk:
      [CRYPTO] padlock-sha: Make 2 functions static

Herbert Xu:
      [CRYPTO] api: Fixed crypto_tfm context alignment
      [CRYPTO] api: Rename crypto_alg_get to crypto_mod_get
      [CRYPTO] api: Add crypto_alg reference counting
      [IPSEC]: Move linux/crypto.h inclusion out of net/xfrm.h
      [CRYPTO] api: Split out low-level API
      [CRYPTO] api: Add template registration
      [CRYPTO] api: Added event notification
      [CRYPTO] api: Add cryptomgr
      [CRYPTO] api: Allow algorithm lookup by type
      [CRYPTO] api: Added spawns
      [CRYPTO] padlock: Add compatibility alias after rename
      [CRYPTO] crc32c: Fix unconventional setkey usage
      [CRYPTO] api: Get rid of flags argument to setkey
      [CRYPTO] digest: Store temporary digest in tfm
      [CRYPTO] tcrypt: Use test_hash for crc32c
      [CRYPTO] cipher: Removed special IV checks for ECB
      [CRYPTO] api: Add common instance initialisation code
      [CRYPTO] api: Added asynchronous flag
      [CRYPTO] s390: Added missing driver name and priority
      [CRYPTO] api: Added crypto_alloc_base
      [CRYPTO] api: Feed flag directly to crypto_yield
      [CRYPTO] api: Added crypto_type support
      [CRYPTO] cipher: Added encrypt_one/decrypt_one
      [CRYPTO] scatterwalk: Prepare for block ciphers
      [CRYPTO] cipher: Added block cipher type
      [CRYPTO] cipher: Added block ciphers for CBC/ECB
      [CRYPTO] padlock: Added block cipher versions of CBC/ECB
      [CRYPTO] s390: Added block cipher versions of CBC/ECB
      [CRYPTO] tcrypt: Use block ciphers where applicable
      [BLOCK] cryptoloop: Use block ciphers where applicable
      [BLOCK] dm-crypt: Use block ciphers where applicable
      [IPSEC]: Add compatibility algorithm name support
      [IPSEC] ESP: Use block ciphers where applicable
      [SUNRPC] GSS: Use block ciphers where applicable
      [CRYPTO] users: Use block ciphers where applicable
      [CRYPTO] drivers: Remove obsolete block cipher operations
      scatterlist: Add const to sg_set_buf/sg_init_one pointer argument
      [CRYPTO] api: Mark parts of cipher interface as deprecated
      [CRYPTO] digest: Added user API for new hash type
      [CRYPTO] hmac: Add crypto template implementation
      [CRYPTO] tcrypt: Use HMAC template and hash interface
      [IPSEC]: Use HMAC template and hash interface
      [SCTP]: Use HMAC template and hash interface
      [CRYPTO] doc: Update documentation for hash and me
      [CRYPTO] digest: Remove old HMAC implementation
      [SCSI] iscsi: Use crypto_hash interface instead of crypto_digest
      [CRYPTO] users: Use crypto_hash interface instead of crypto_digest
      [CRYPTO] api: Add crypto_comp and crypto_has_*
      [CRYPTO] users: Use crypto_comp and crypto_has_*
      [CRYPTO] padlock: Convert padlock-sha to use crypto_hash
      [CRYPTO] api: Deprecate crypto_digest_* and crypto_alg_available

Joachim Fritschi:
      [CRYPTO] twofish: Split out common c code
      [CRYPTO] twofish: Fix the priority
      [CRYPTO] twofish: i586 assembly version
      [CRYPTO] twofish: x86-64 assembly version

Michal Ludvig:
      [CRYPTO] sha: Add module aliases for sha1 / sha256
      [CRYPTO] api: Add missing accessors for new crypto_alg fields
      [CRYPTO] padlock: Get rid of padlock-generic.c
      [CRYPTO] padlock: Update private header file
      [CRYPTO] padlock: Driver for SHA1 / SHA256 algorithms
      [CRYPTO] padlock: Helper module padlock.ko
      [CRYPTO] padlock-sha: TFMs don't need to be static

Rik Snel:
      [BLOCK] dm-crypt: trivial comment improvements


 b/Documentation/crypto/api-intro.txt      |   36 -
 b/arch/i386/crypto/Makefile               |    3 
 b/arch/i386/crypto/aes.c                  |    3 
 b/arch/i386/crypto/twofish-i586-asm.S     |  335 +++++++++++
 b/arch/i386/crypto/twofish.c              |   97 +++
 b/arch/s390/crypto/aes_s390.c             |  285 ++++++---
 b/arch/s390/crypto/crypt_s390.h           |    3 
 b/arch/s390/crypto/des_s390.c             |  559 ++++++++++++------
 b/arch/s390/crypto/sha1_s390.c            |    2 
 b/arch/s390/crypto/sha256_s390.c          |    2 
 b/arch/x86_64/crypto/Makefile             |    3 
 b/arch/x86_64/crypto/aes.c                |    5 
 b/arch/x86_64/crypto/twofish-x86_64-asm.S |  324 ++++++++++
 b/arch/x86_64/crypto/twofish.c            |   97 +++
 b/crypto/Kconfig                          |  154 ++++-
 b/crypto/Makefile                         |   16 
 b/crypto/aes.c                            |    5 
 b/crypto/algapi.c                         |  486 ++++++++++++++++
 b/crypto/anubis.c                         |    3 
 b/crypto/api.c                            |  428 +++++++++-----
 b/crypto/arc4.c                           |    2 
 b/crypto/blkcipher.c                      |  405 +++++++++++++
 b/crypto/blowfish.c                       |    3 
 b/crypto/cast5.c                          |    8 
 b/crypto/cast6.c                          |    5 
 b/crypto/cbc.c                            |  344 +++++++++++
 b/crypto/cipher.c                         |  117 +++
 b/crypto/crc32c.c                         |   30 
 b/crypto/crypto_null.c                    |    2 
 b/crypto/cryptomgr.c                      |  156 +++++
 b/crypto/des.c                            |    6 
 b/crypto/digest.c                         |  155 +++--
 b/crypto/ecb.c                            |  181 ++++++
 b/crypto/hash.c                           |   61 ++
 b/crypto/hmac.c                           |  278 ++++++---
 b/crypto/internal.h                       |  106 ++-
 b/crypto/khazad.c                         |    8 
 b/crypto/michael_mic.c                    |    5 
 b/crypto/proc.c                           |   13 
 b/crypto/scatterwalk.c                    |   89 +-
 b/crypto/scatterwalk.h                    |   52 -
 b/crypto/serpent.c                        |   19 
 b/crypto/sha1.c                           |    3 
 b/crypto/sha256.c                         |    3 
 b/crypto/tcrypt.c                         |  901 +++++++++++++++---------------
 b/crypto/tcrypt.h                         |  202 ++++++
 b/crypto/tea.c                            |   16 
 b/crypto/twofish.c                        |  700 -----------------------
 b/crypto/twofish_common.c                 |  744 ++++++++++++++++++++++++
 b/drivers/block/cryptoloop.c              |  160 +----
 b/drivers/crypto/Kconfig                  |   45 +
 b/drivers/crypto/Makefile                 |    8 
 b/drivers/crypto/padlock-aes.c            |  258 ++++++--
 b/drivers/crypto/padlock-sha.c            |  318 ++++++++++
 b/drivers/crypto/padlock.c                |   58 +
 b/drivers/crypto/padlock.h                |   17 
 b/drivers/md/dm-crypt.c                   |  146 ++--
 b/drivers/net/ppp_mppe.c                  |   68 +-
 b/drivers/net/wireless/airo.c             |   22 
 b/drivers/scsi/iscsi_tcp.c                |  134 ++--
 b/drivers/scsi/iscsi_tcp.h                |    9 
 b/fs/nfsd/nfs4recover.c                   |   21 
 b/include/crypto/algapi.h                 |  156 +++++
 b/include/crypto/twofish.h                |   22 
 b/include/linux/crypto.h                  |  689 ++++++++++++++++++++--
 b/include/linux/scatterlist.h             |    4 
 b/include/linux/sunrpc/gss_krb5.h         |   19 
 b/include/linux/sunrpc/gss_spkm3.h        |    4 
 b/include/net/ah.h                        |   30 
 b/include/net/esp.h                       |   31 -
 b/include/net/ipcomp.h                    |    5 
 b/include/net/sctp/constants.h            |    4 
 b/include/net/sctp/sctp.h                 |   11 
 b/include/net/sctp/structs.h              |    3 
 b/include/net/xfrm.h                      |   12 
 b/net/ieee80211/ieee80211_crypt_ccmp.c    |   32 -
 b/net/ieee80211/ieee80211_crypt_tkip.c    |   59 +
 b/net/ieee80211/ieee80211_crypt_wep.c     |   25 
 b/net/ipv4/Kconfig                        |    1 
 b/net/ipv4/ah4.c                          |   36 -
 b/net/ipv4/esp4.c                         |   85 +-
 b/net/ipv4/ipcomp.c                       |   25 
 b/net/ipv6/Kconfig                        |    1 
 b/net/ipv6/ah6.c                          |   35 -
 b/net/ipv6/esp6.c                         |   90 +-
 b/net/ipv6/ipcomp6.c                      |   25 
 b/net/sctp/endpointola.c                  |    2 
 b/net/sctp/sm_make_chunk.c                |   37 -
 b/net/sctp/socket.c                       |    6 
 b/net/sunrpc/auth_gss/gss_krb5_crypto.c   |   95 +--
 b/net/sunrpc/auth_gss/gss_krb5_mech.c     |   24 
 b/net/sunrpc/auth_gss/gss_krb5_seqnum.c   |    4 
 b/net/sunrpc/auth_gss/gss_krb5_wrap.c     |    4 
 b/net/sunrpc/auth_gss/gss_spkm3_mech.c    |   29 
 b/net/xfrm/xfrm_algo.c                    |   94 ++-
 b/net/xfrm/xfrm_user.c                    |    2 
 b/security/seclvl.c                       |   18 
 drivers/crypto/padlock-generic.c          |   63 --
 98 files changed, 7726 insertions(+), 2780 deletions(-)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
