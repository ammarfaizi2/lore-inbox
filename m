Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274423AbRITLIv>; Thu, 20 Sep 2001 07:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274424AbRITLIm>; Thu, 20 Sep 2001 07:08:42 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:50194 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S274423AbRITLId>;
	Thu, 20 Sep 2001 07:08:33 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Dan Hollis <goemon@anime.net>
Date: Thu, 20 Sep 2001 13:08:25 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
CC: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>,
        ebiederm@xmission.com
X-mailer: Pegasus Mail v3.40
Message-ID: <3FD9CFB2E5A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Sep 01 at 15:13, Dan Hollis wrote:
> On 19 Sep 2001, Eric W. Biederman wrote:
> > Of course VIA looking at what they have done and what that bit is
> > supposed to be is easiest as they have the schemantics of those
> > chips.  But there is not reason to be limited to just that approach.

Well, I want to add some confusion into this thread...
 
> We definitely need more data points too. So far we dont have any athlon.c
> data for kt133a with the bit on and off, only kt133.

... I have at home Asus A7V (with KT133, non A), it has register 0x55
set to 0x89 and I thought that it works fine. I modified athlon.c
so that it fills buffer with random data on start, and then it compares
results of copy_page. And after about 10th run with 0x89 promise
driver told me that func:13 (not 14...) is not supported and all HDDs
became inaccessible. After reboot portion of /usr/include/bits (and 
few other) was overwritten with 0xFF... I was not able to recreate 
this problem after that crash (but I did not tried too hard, as I have
important data on my hdds, and all hdds attached to promise were
affected, not only one which was 'active' before crash (I was doing
compilation & logged outputs on secondary master, but primary master
was corrupted...)

After fsck, reinstalling libc6-dev and apache-doc, I started playing
with 0x55 bits and found that bits 0x80 and 0x01 have no effect on
performance, but CLEARING bit 0x08 increases my motherboard performace
by 1% (I'm getting very consistent results, they vary around +-10 cycles,
with 12200 cycles with 0x08 and 12060 with 0x00 in register 0x55).

So I personally will apply this patch even on my KT133... And just
for completness, kernel 2.4.9-ac10 (with AMD opts), Athlon 1GHz, two
singlesided 128MB DIMMs, interleaving enabled (disabling slows down
K7 copy page system by 4%).
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
