Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbQLWSVB>; Sat, 23 Dec 2000 13:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbQLWSUl>; Sat, 23 Dec 2000 13:20:41 -0500
Received: from natmail2.webmailer.de ([192.67.198.65]:44192 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S129667AbQLWSUk>; Sat, 23 Dec 2000 13:20:40 -0500
From: Stefan Hoffmeister <Stefan.Hoffmeister@Econos.de>
To: linux-kernel@vger.kernel.org
Subject: 8139too driver broken? (2.4-test12) - Was: Re: rtl8139 driver broken? (2.2.16)
Date: Sat, 23 Dec 2000 18:50:53 +0100
Organization: Econos
Message-ID: <6kn94tohu3v901eeod2nf94ish0ct33cci@4ax.com>
In-Reply-To: <vb074t8d27bdedg6m7pv4c4qqu1f8324cq@4ax.com> <E149X1l-00051k-00@the-village.bc.nu>
In-Reply-To: <E149X1l-00051k-00@the-village.bc.nu>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: On Fri, 22 Dec 2000 18:34:46 +0000 (GMT), Alan Cox wrote:

>2.2.18 might help and also as an '8139too' driver rewrite which may work 

Advancing further to a 2.4-test12 kernel (with the latest available
8139too driver - 0.9.12) improves the situation even further, but doesn't
solve it.

I still cannot "ping -s 5000 192.168.0.55" from the 8139too machine, but
at least I can now FTP the 2.4-test12 kernel (18 MB) from another machine
to the 8139 target without any stalls. The rather major problem that
remains is performance.

As before: 
  * 192.168.0.77 = 8139too (2.4-test12, SuSE 7.0); 
           HP Omnibook 800; P133; 48 MB

  * 192.168.0.55 = eepro100 (2.2.16, SuSE 7.0);
           Sony VAIO Z600NE, PIII 650, 256 MB

FTP from 192.168.0.55 (eepro100) to 192.168.0.77 (8139too):

  put linux-2.4.0-test12.tar.bz2
    18975167 bytes sent in 00:48 (385.71 KB/s)

  get linux-2.4.0-test12.tar.bz2
    18975167 bytes received in 00:05 (3.18 MB/s)

FTP from 192.168.0.77 (8139too) to 192.168.0.55 (eepro100):

  get linux-2.4.0-test12.tar.bz2
    18975167 bytes sent in 00:34 (530.39 KB/s)

  put linux-2.4.0-test12.tar.bz2
    18975167 bytes sent in 00:05 (3.13 MB/s)


IOW, when the 8139too driver itself *delivers* data (put initiated from
192.168.0.77, get initiated from 192.168.0.55), I get 3 MB/s throughput,
pretty much what I would expect.

When the 8139too driver gets data pushed down its throat (get initiated
from 192.168.0.77, put initiated from 192.168.0.55), then performance
plainly does not exist.

Any ideas?

TIA!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
