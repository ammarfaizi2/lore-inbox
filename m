Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277330AbRKDScX>; Sun, 4 Nov 2001 13:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281080AbRKDScP>; Sun, 4 Nov 2001 13:32:15 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:39942 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S281072AbRKDSbx>; Sun, 4 Nov 2001 13:31:53 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: [Patch] Re: Nasty suprise with uptime
Date: Sun, 4 Nov 2001 18:31:33 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <Pine.LNX.4.30.0110311902410.29481-100000@gans.physik3.uni-rostock.de>
    <3BE08108.91067996@mvista.com>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1004898693 8629 10.253.0.3 (4 Nov 2001 18:31:33
    GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Sun, 4 Nov 2001 18:31:33 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:122756
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <9s41i5$8dl$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another way is to have jiffies still be a normal 32-bit counter, and have
another 32 bit value (high_jiffy) whose low bit is supposed to be equal to
the hight bit of the jiffy value. Set up a timer to repeatedly but rarely
check the high bit of jiffy and if it's different from the low bit of
high_jiffy, increase high_jiffy by one. In the rare cases you need to read
the full 64-bit (or rather, 63-bit) value, do the same test and combine the
two parts dropping one bit in the middle. (high_jiffy access would be locked)

This makes 63-bit read slow, but lets normal jiffy ops proceed at
normal speed. in fact, this method can be used to make any 32-bit counter
into a big counter without real speed loss if full length reads are rare
