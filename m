Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVCGU31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVCGU31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVCGU3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:29:23 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:5297 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261773AbVCGUMc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:32 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [??/many] acrypto benchmarks vs cryptoloop vs dm_crypt
In-Reply-To: <11102278521366@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:33 +0300
Message-Id: <1110227853899@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benchmark: Bonnie++ 1.03.
Machine: 2-way Xeon (1+1HT), 1Gb ram.
Ext2 filesystem over file(mapped using loop(cryptoloop, dm_crypt) 
or bd_fd filter for bd).

Version  @version@      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
acrypto       2500M  5479  74  8122   5  4886   4  5690  73 10713   4  22.0   0
cryptoloop    2500M  5812  71 10437   7  4402   5  7165  92 10763   6  88.3   0
dm_crypt      2500M  6040  90  6747  36  4768   8  5775  66 10161   5  90.6   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
acrypto          16  1345  99 +++++ +++ +++++ +++  1403  99 +++++ +++  4538 100
cryptoloop       16  1372  99 +++++ +++ +++++ +++  1405  99 +++++ +++  4501  99
dm_crypt         16  1352  99 +++++ +++ +++++ +++  1371  99 +++++ +++  4278 100


bd+acrypto works exactly as cryptoloop (attitude of the performance 
acrypto vs. cryptoloop is always the same as CPU usage attitude, 
BUT!, I can not setup bd+acrypto to use the same amount of CPU as loopdev!,
so in absolute numbers, cryptoloop is faster).
dm_crypt is slower.


