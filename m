Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWEGJ5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWEGJ5E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 05:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWEGJ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 05:57:04 -0400
Received: from mout1.freenet.de ([194.97.50.132]:8845 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932109AbWEGJ5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 05:57:02 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 1/2] Twofish cipher i586-asm optimized
Date: Sun, 7 May 2006 11:56:57 +0200
User-Agent: KMail/1.8.3
Cc: herbert@gondor.apana.org.au, davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071156.57844.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation:
-----------------------
This code is based on the current linux twofish cipher c implementation. Only 
the decrypt/encrypt routines were replaced by optimized assembler code. The 
in-kernel code by Matthew Skala takes care of the keysetup and precomputation 
of the sbox lookup tables.
I have tried to cut down stack use to a minimum (1 push/pop per round) and 
optimize the code as much as possible. The patch is similar to the existing 
aes assembler implementation.

Testing:
-----------
The code passed the kernel test module and passed automated tests on a 
dm-crypt volume reading/writing large files with alternating modules ( c / 
assembler ) and comparing results.

Benchmarks:
-------------------

Performance on a dm-crypt volume increased about 30% while reading. With 
256bit keylength it even outperformed the 128bit aes assembler code.

http://homepages.tu-darmstadt.de/~fritschi/twofish/output_20060417_185029_x86.html

The write performance in this benchmark was limited by the harddrive and not 
the algorithm / system speed. Any suggestions how to benchmark the overall 
speed accurately are welcome.


Patch:
----------

http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-i586-asm-2.6.17.diff


Please have a look, try, improve and criticise.

Regards,
Joachim



