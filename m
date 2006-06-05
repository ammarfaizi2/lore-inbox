Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750950AbWFEKry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWFEKry (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWFEKry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:47:54 -0400
Received: from mout2.freenet.de ([194.97.50.155]:41606 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1750950AbWFEKrx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:47:53 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH 3/4] Twofish cipher - i586 assembler
Date: Mon, 5 Jun 2006 12:47:49 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ak@suse.de
References: <200606042249.k54MnbFW010695@laptop11.inf.utfsm.cl>
In-Reply-To: <200606042249.k54MnbFW010695@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606051247.49243.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 June 2006 00:49, Horst von Brand wrote:
> Joachim Fritschi <jfritschi@freenet.de> wrote:
> > This patch adds the twofish i586 assembler routine.
>
> What performance impact does this have on a variety of machines? 

Here are the outputs from the tcrypt speedtests. They haven't changed much 
since the last patch:

http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-c-i586.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-asm-i586.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-c-x86_64.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-asm-x86_64.txt

Summary for cycles used for CBC encrypt decrypt (256bit / 8k blocks) assembler 
vs. generic-c:

i586 encrypt:   - 17%
i568 decrypt:   -24%
x86_64 encrypt: -22%
x86_64 decrypt: -17%

The numbers vary a bit with different blocksizes / keylength and per test.

I also did some filesystem benchmarks (bonnie++) with various ciphers. Most 
write tests maxed out my drives writing to disk.  But at least for the read 
speed you can see some notable performance improvements:
(Note: The x86 and x86_64 numbers are not comparable since the tests were done 
on different machines)

http://homepages.tu-darmstadt.de/~fritschi/twofish/output_20060531_160442_x86.html

Summary:
Sequential read speed improved between 25-32%
Sequential write speed improved at least 15% but the disk maxed out
Twofish 256 is a little bit faster than AES 128

http://homepages.tu-darmstadt.de/~fritschi/twofish/output_20060601_113747_x86_64.html

Summary:
Sequential read speed improved 13%
Seqential write speed maxed out the drives

> Is twofish used enough for this to be relevant?

I don't have hard facts about that, but i have been using it for many year. 
Since Suse included it in there release 7.0 a few years back. Don't know what 
the current status in the various distributions is. I guess it is probably 
the second most used cipher behind aes since the performance for 256bit 
keylength is better or close to the aes speed. Some cryptoanalyst believe it 
to be cryptograhically superior to aes but that is probably a matter of 
opinion and parameters you consider. In the NIST competition it was third 
behind aes and serpent. Serpent itself is probably more secure but lacks 
performance. Twofish is probably also one of the cipher you choose from if 
you don't trust the US government to choose the right one for you. :)

Regards,

Joachim

