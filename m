Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317693AbSGUPjF>; Sun, 21 Jul 2002 11:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSGUPjF>; Sun, 21 Jul 2002 11:39:05 -0400
Received: from dsl-213-023-043-192.arcor-ip.net ([213.23.43.192]:11931 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317693AbSGUPjE>;
	Sun, 21 Jul 2002 11:39:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code v3
Date: Sun, 21 Jul 2002 17:43:42 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020719011300.548d72d5.arodland@noln.com> <20020720173222.3286fcbb.arodland@noln.com>
In-Reply-To: <20020720173222.3286fcbb.arodland@noln.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17WIs3-0005to-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my contribution to the ongoing beautification:

static const unsigned char morsetable[] = {
	0122, 0, 0310, 0, 0, 0163,			/* "#$%&' */
	055, 0155, 0, 0, 0163, 0141, 0152, 0051, 	/* ()*+,-./ */
	077, 076, 074, 070, 060, 040, 041, 043, 047, 057, /* 0-9 */
	0107, 0125, 0, 0061, 0, 0114, 0, 		/* :;<=>?@ */
	006, 021, 025, 011, 002, 024, 013, 020, 004,	/* A-I */
	036, 015, 022, 007, 005, 017, 026, 033, 012,	/* J-R */
	010, 003, 014, 030, 016, 031, 035, 023,		/* S-Z */
	0, 0, 0, 0, 0154				/* [\]^_ */
};

unsigned char tomorse(char c)
{
	return c >= '"' && c <= '_'? morsetable[c - '"']: 0;
}

used as:

+			if (!(morse = tomorse(toupper(*bufpos)))) {
+                               next_jiffie = jiffies + SPACELEN; /*Space -- For a total of 7*/
+                               state = 1; /* And bring us back here when we're done */
+                       }

-- 
Daniel
