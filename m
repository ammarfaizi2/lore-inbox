Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131278AbRCNCtR>; Tue, 13 Mar 2001 21:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131279AbRCNCtH>; Tue, 13 Mar 2001 21:49:07 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:38156 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S131278AbRCNCsw>; Tue, 13 Mar 2001 21:48:52 -0500
Message-Id: <m14d1KU-0005khC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: another Cyrix/mtrr problem?
In-Reply-To: <Pine.LNX.4.31.0103140009230.7143-100000@athlon>
 "from davej@suse.de at Mar 14, 2001 00:20:21 am"
To: davej@suse.de
Date: Tue, 13 Mar 2001 20:48:02 -0600 (CST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:
> Normally the answer would be "Closed driver, complain to nVidia",
> but just in case..

Glad you were open-minded enough to consider that it *might* be
"our" code.

> Can you verify that..
> 
>  a. You have MTRR support compiled into the kernel.

yes

>  b. You have a /proc/mtrr file

yes

>  c. You can add/delete ranges using /proc/mtrr
>     (See Documentation/mtrr.txt for info on how to do this)

yes, BUT...

The "Documentation/mtrr.txt" file says "... 4 megabytes, which is
0x400000 bytes (in hexadecimal)."  The math is correct: 1MB == 2**20
== 0x100000 the last time I checked.  Unfortunately, when I execute

echo "base=0xd8000000 size=0x100000 type=write-combining" >| /proc/mtrr

I get a 2MB region instead of the 1MB region I expected...

reg00: base=0xd8000000 (3456MB), size=   2MB: write-combining, count=1
reg01: base=0x000c0000 (   0MB), size= 512KB: uncachable, count=1
reg07: base=0x00000000 (   0MB), size= 256MB: write-through, count=1

Similarly, the NVIDIA driver attempts to create a 32MB write-combining
region by passing a size argument of 0x2000000, and fails because the
underlying mtrr code tries to carve out a 64MB region whereas my video
card has only 32MB of RAM.

Looks like an off-by-one (bit) error to me.  So...  Is this a legitimate
bug sighting, or is my analysis faulty?

--Bob Tracy
rct@frus.com
