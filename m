Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313180AbSC1RSL>; Thu, 28 Mar 2002 12:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313186AbSC1RSB>; Thu, 28 Mar 2002 12:18:01 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:33674 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S313180AbSC1RRw>; Thu, 28 Mar 2002 12:17:52 -0500
Date: Thu, 28 Mar 2002 09:18:07 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Questions about /proc/stat
In-Reply-To: <20020328163907.GA5815@ghost.anime.pl>
Message-ID: <Pine.LNX.4.33.0203280908530.1795-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some questions about the "page" and "swap" entries in /proc/stat.
Here is the relevant code from 2.4.12
/usr/src/linux/fs/proc/proc_misc.c:

    292         len += sprintf(page + len,
    293                 "page %u %u\n"
    294                 "swap %u %u\n"
    295                 "intr %u",
    296                         kstat.pgpgin >> 1,
    297                         kstat.pgpgout >> 1,
    298                         kstat.pswpin,
    299                         kstat.pswpout,
    300                         sum
    301         );

1. Why are kstat.pgpgin and kstat.pgpgout shifted right / halved?

2. Are the "page" and "swap" numbers mutually exclusive? That is, if a
page is brought in from swap and counted in kstat.pswpin, is it also
counted in kstat.pgpgin? I found the places in the code where the counts
are incremented, but I couldn't tell if the swapin routine calls the
block driver or not.
--
M. Edward Borasky

znmeb@borasky-research.net

Actually, for their size, elephants don't smell all that bad.

