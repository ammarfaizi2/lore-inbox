Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136395AbRD2WdO>; Sun, 29 Apr 2001 18:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136397AbRD2WdE>; Sun, 29 Apr 2001 18:33:04 -0400
Received: from elin.scali.no ([195.139.250.10]:39694 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S136395AbRD2Wcw>;
	Sun, 29 Apr 2001 18:32:52 -0400
Message-ID: <3AEC9823.EEC8EC46@scali.no>
Date: Sun, 29 Apr 2001 17:39:31 -0500
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17-16enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nick@snowman.net
CC: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>,
        lkml <linux-kernel@vger.kernel.org>, davej@suse.de, troels@thule.no
Subject: Re: ServerWorks LE and MTRR
In-Reply-To: <Pine.LNX.4.21.0104291813490.32327-100000@ns>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nick@snowman.net wrote:
> On Sun, 29 Apr 2001, Steffen Persvold wrote:
> 
> > I've learned it the hard way, I have two types : Compaq DL360 (rev 5) and a
> > Tyan S2510 (rev 6). On the compaq machine I constantly get data corruption on
> > the last double word (4 bytes) in a 64 byte PCI burst when I use write
> > combining on the CPU. On the Tyan however the transfer is always ok.
> >
> 
> Are you sure that is not due to board design differences?

No I can't be 100% certain that the layout of the board isn't the reason since
I haven't asked ServerWorks about this and it doesn't say anything in their
docs (yes my company has the NDA, so I shouldn't get to much in detail here),
but if this was the case it would be totally wrong to disable write combining
on any LE chipset.

The test case that I have been using to trigger this is sort of special because
we are using SCI shared memory adapters to write (with PIO) into remote nodes
memory, and the bandwidth tends to get quite high (approx 170 MByte/sec on LE
with write combining). I've been able to run this case on 5 different
motherboards using the LE and HE-SL ServerWorks chipsets, but only two of them
are LE (the DL360 and the S2510). Everything works fine with write-combining on
every motherboard except the DL360 (which has rev 5).

One basic test case that I haven't tried, could be to enable write-combining on
your PCI graphics adapter memory and see if the X display gets screwed up.

I will try to get some information from ServerWorks about this problem, but I'm
not sure if ServerWorks would be happy if I told you the answer (because of the
NDA).

Regards,
-- 
 Steffen Persvold                        Systems Engineer
 Email  : mailto:sp@scali.com            Scali AS (http://www.scali.com)
 Norway : Tel  : (+47) 2262 8950         Olaf Helsets vei 6
          Fax  : (+47) 2262 8951         N-0621 Oslo, Norway

 USA    : Tel  : (+1) 713 706 0544       10500 Richmond Avenue, Suite 190
                                         Houston, Texas 77042, USA
