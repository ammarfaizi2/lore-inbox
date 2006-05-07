Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWEGMrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWEGMrS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 08:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWEGMrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 08:47:18 -0400
Received: from mout2.freenet.de ([194.97.50.155]:3506 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932136AbWEGMrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 08:47:17 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/2]  Twofish cipher x86_64-asm optimized
Date: Sun, 7 May 2006 14:47:15 +0200
User-Agent: KMail/1.8.3
References: <200605071157.03362.jfritschi@freenet.de> <p73odya3ys9.fsf@bragg.suse.de>
In-Reply-To: <p73odya3ys9.fsf@bragg.suse.de>
Cc: linux-crypto@vger.kernel.org, Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071447.15485.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Testing:
> > -----------
> > The code passed the kernel test module and passed automated tests on a
> > dm-crypt volume reading/writing large files with alternating modules ( c
> > / assembler ) and comparing results. It is also running on my workstation
> > for over a week now.
>
> It would be good if you could run some random input encrypt/decrypt tests
> comparing the C reference version with yours. We have had bad luck
> with assembler functions not quite implementing the same cipher
> in the past.

That's exactly what my skript did.

http://homepages.tu-darmstadt.de/~fritschi/twofish/test_twofish.sh

Be careful with this script. It formats the testpartition you specify. The 
script assumes you have both modules (c and asm) compiled as modules.
It generates a 1Gb random file and a random passphrase. It copies the file on 
your crypted partition with the c module and reads it again with the asm 
module. Then it copies the file again onto the crypto partition with the asm 
module and reads it with the c module. After each step the md5sum of the 
files are compared with the original file. Then the script starts all over 
again with a new random file and passphrase.

My modules also pass the tcrypt tests.

> > Please have a look, try, improve and criticise.
>
> Is it really needed to duplicate all the C code and tables - can't that
> be shared with the portable C code?

I really don't know. I'm quite a newbie when it comes to kernel programming. 
Maybe there is a way, but my reference for this module was the aes assembler 
code which duplicates everything as well. I assumed there is reason for this. 
Maybe someone with a little more knowledge about the crypto-api / kernel 
could pitch in here.
>
> Also don't make it a separate config - it should just be a replacement
> on x86-64.

There was a patch in 2.6.16:
-------------------------
commit c8a19c91b5b488fed8cce04200a84c6a35c0bf0c
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sat Nov 5 18:06:26 2005 +1100

    [CRYPTO] Allow AES C/ASM implementations to coexist
    
    As the Crypto API now allows multiple implementations to be registered
    for the same algorithm, we no longer have to play tricks with Kconfig
    to select the right AES implementation.
    
    This patch sets the driver name and priority for all the AES
    implementations and removes the Kconfig conditions on the C implementation
    for AES.
------------------------------

That's why i did it the same way. 




