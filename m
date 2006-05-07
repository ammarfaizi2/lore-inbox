Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWEGJ5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWEGJ5J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 05:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWEGJ5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 05:57:09 -0400
Received: from mout1.freenet.de ([194.97.50.132]:5774 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932111AbWEGJ5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 05:57:06 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2/2]  Twofish cipher x86_64-asm optimized
Date: Sun, 7 May 2006 11:57:03 +0200
User-Agent: KMail/1.8.3
Cc: herbert@gondor.apana.org.au, davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071157.03362.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation:
-----------------------
This code is based on the current linux twofish cipher c implementation. Only 
the decrypt/encrypt routines were replaced by optimized assembler code. The 
in-kernel code by Matthew Skala takes care of the keysetup and precomputation 
of the sbox lookup tables.
I have eliminated stack use, tried to optimize the code as much as possible 
and limit code size. The patch is similar to the existing aes assembler 
implementation.

Testing:
-----------
The code passed the kernel test module and passed automated tests on a 
dm-crypt volume reading/writing large files with alternating modules ( c / 
assembler ) and comparing results. It is also running on my workstation for 
over a week now.

Benchmarks:
-------------------

Performance on a dm-crypt volume increased about 47% while reading. With 
256bit keylength its pretty close to the speed of the aes assembler version.

http://homepages.tu-darmstadt.de/~fritschi/twofish/output_20060426_175710_x86_64.html

The write performance in this benchmark was limited by the harddrive and not 
the algorithm / system speed. Any suggestions how to benchmark the overall 
speed accurately are welcome.


Patch:
----------

http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-x86_64-asm-2.6.17.diff


Please have a look, try, improve and criticise.

Regards,
Joachim
