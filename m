Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAXIF0>; Wed, 24 Jan 2001 03:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRAXIFH>; Wed, 24 Jan 2001 03:05:07 -0500
Received: from colorfullife.com ([216.156.138.34]:34308 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129764AbRAXIFA>;
	Wed, 24 Jan 2001 03:05:00 -0500
Message-ID: <3A6E0CEA.ABD620F8@colorfullife.com>
Date: Tue, 23 Jan 2001 23:59:54 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: dwd@bell-labs.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
In-Reply-To: <3A6E02E6.B3261E1@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I checked RFC793, and AFAICS Solaris is the culprit:
it sends out invalid packets, Linux ignores them and thus Linux doesn't
receive acks.

Which Solaris version do you use?

* The last valid ack from the Solaris computer is for byte 1583721, win
8760 (line 2078)

* No packet after line 2078 from the Solaris computer passed the
acceptability test from RFC793, page 69. Thus Linux ignores these
packets completely.

* Linux sends out packets up to 1591021:1592481(1460) without receiving
_valid_ acks, then it begins to retry 1583721:1585181(1460) every 2
seconds until the end of the tcpdump.

--	
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
