Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266010AbUFUCHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUFUCHy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 22:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbUFUCHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 22:07:53 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:44498 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266010AbUFUCGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 22:06:31 -0400
Date: Mon, 21 Jun 2004 04:06:27 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm1 linker trouble with CONFIG_FB_RIVA_I2C=y and modular I2C
Message-ID: <20040621020627.GA10824@merlin.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040620174632.74e08e09.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20040620174632.74e08e09.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, 20 Jun 2004, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm1/

This version causes linker trouble with
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_FB_RIVA_I2C=y

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xda101): In function `riva_setup_i2c_bus':
: undefined reference to `i2c_bit_add_bus'
drivers/built-in.o(.text+0xda218): In function `riva_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0xda237): In function `riva_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0xda2c9): In function `riva_do_probe_i2c_edid':
: undefined reference to `i2c_transfer'
make: *** [.tmp_vmlinux1] Error 1

Setting CONFIG_FB_RIVA_I2C to "n" fixes the build problem.

Setting CONFIG_I2C and CONFIG_I2C_ALGOBIT to "y" (I used to use "m")
also fixes the build problem.

Full failing .config is attached (comments stripped, gzipped).

-- 
Matthias Andree

--CE+1k2dSO48ffgeK
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="failconfig.gz"
Content-Transfer-Encoding: base64

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
Jy4AAA==

--CE+1k2dSO48ffgeK--
