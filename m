Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbRAXIF0>; Wed, 24 Jan 2001 03:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAXIFH>; Wed, 24 Jan 2001 03:05:07 -0500
Received: from colorfullife.com ([216.156.138.34]:34820 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129776AbRAXIFB>;
	Wed, 24 Jan 2001 03:05:01 -0500
Message-ID: <3A6E02E6.B3261E1@colorfullife.com>
Date: Tue, 23 Jan 2001 23:17:10 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: dwd@bell-labs.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read through the tcpdump, and it seems that Linux completely ignores
packets with out-of-window sequence numbers:


* the solaris computers (dynamic...) sends further data although the
Linux box (static) says 'win 0'.
See lines 2067, 2069, 2076, ...
2066  16:31:43.108759 eth0 > static.8664 > dynamic.ih.lucent.com.39406:
. 1583720:1583720(0) ack 69041 win 0 (DF)
2067  16:31:43.110623 eth0 < dynamic.ih.lucent.com.39406 > static.8664:
P 69041:69628(587) ack 1583721 win 0 (DF)


2078  16:31:43.896657 eth0 < dynamic.ih.lucent.com.39406 > static.8664:
. 69041:69041(0) ack 1583721 win 8760 (DF)
* this is the last ack with an in-window sequence number.
.
.
.
2136  16:35:08.488774 eth0 > static.8664 > dynamic.ih.lucent.com.39406:
. 1583721:1585181(1460) ack 69041 win 0 (DF)
* the linux computer sends data
2137  16:35:08.492158 eth0 < dynamic.ih.lucent.com.39406 > static.8664:
. 70501:70501(0) ack 1592481 win 8760 (DF)
* but ignores the ack, probably because the sequence number is out of
window

Perhaps someone who understand TCP could check the code and compare it
with the RFC's?

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
