Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132496AbRD1XxJ>; Sat, 28 Apr 2001 19:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbRD1XxA>; Sat, 28 Apr 2001 19:53:00 -0400
Received: from www.linux.org.uk ([195.92.249.252]:24082 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S132496AbRD1Xwo>;
	Sat, 28 Apr 2001 19:52:44 -0400
Date: Sun, 29 Apr 2001 00:52:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Zerocopy implementation issues
Message-ID: <20010429005206.J21792@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can someone please explain to me the rationale behind the zerocopy
implementation that has appeared in 2.4.4 please?

The reason I ask is that even on x86, it seems to me to be extremely
silly to have the expense of doing unaligned checksumming for the gain
of zerocopy.

Just think - if you did checksumming on aligned word boundaries you
could be far faster!

(Yes, you guessed it, its broken on ARM, and is going to make the
networking layer pig slow if we keep the current implementation as
it stands due to the phenominal amount of exceptions it _will_
generate - 1 exception per word in a packet).

I'm still investigating the source of the networking corruptions I'm
seeing, but its looking like the above is the reason (data is being
corrupted on TCP send).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

