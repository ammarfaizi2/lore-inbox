Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130008AbRAYLpR>; Thu, 25 Jan 2001 06:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132252AbRAYLpH>; Thu, 25 Jan 2001 06:45:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14982 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130008AbRAYLoz>;
	Thu, 25 Jan 2001 06:44:55 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.4487.540768.312023@pizda.ninka.net>
Date: Thu, 25 Jan 2001 03:44:07 -0800 (PST)
To: Andi Kleen <ak@suse.de>
Cc: kuznet@ms2.inr.ac.ru, Manfred Spraul <manfred@colorfullife.COM>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
In-Reply-To: <20010125124036.A15952@gruyere.muc.suse.de>
In-Reply-To: <3A6E02E6.B3261E1@colorfullife.com>
	<200101242003.XAA21040@ms2.inr.ac.ru>
	<20010124215634.A2992@gruyere.muc.suse.de>
	<14960.3804.197814.496909@pizda.ninka.net>
	<20010125124036.A15952@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > > BSD and Solaris both make these kinds of packets, therefore it is must
 > > to handle them properly.  So we will fix Linux, there is no argument.
 > 
 > How do you propose to handle them? Queue the data anyways or just process
 > the ACK?

tcp_sequence returns two flag bits instead of it's current binary
state.  One bit says "accept data", the other says "accept control
bits" (such as RST, ACK, etc.)

tcp_sequence also will truncate the data len of the SKB area if
necessary, BSD really puts total crap in the probe byte.

Callers of tcp_sequence check the return value bits accordingly.
This is all slow path code, so there are no performance issues.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
