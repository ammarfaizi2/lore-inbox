Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbTAHU2u>; Wed, 8 Jan 2003 15:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267893AbTAHU2t>; Wed, 8 Jan 2003 15:28:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9346 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267890AbTAHU2s>; Wed, 8 Jan 2003 15:28:48 -0500
Date: Wed, 8 Jan 2003 15:40:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrew McGregor <andrew@indranet.co.nz>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
In-Reply-To: <81050000.1042056570@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1030108151955.416A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Andrew McGregor wrote:

> Actually, talking to some people off-list, I realised that what happened 
> with the instances I saw was probably that the packets were corrupted 
> inside the host, somewhere after the ethernet checksum had done its job. 
> DMA problems or a slow address line on some RAM somewhere could easily beat 
> the TCP checksum, but as many folks have pointed out, ethernet CRC is much 
> stronger.
> 
> Having seen something odd like that in practice, I overestimated the 
> probability of these problems.
> 
> It was also pointed out that iSCSI also makes it's CRC optional only if 
> there is some other mechanism (ESP, AH or some other high-integrity 
> transport) providing the data integrity.  Partly this is because that 
> checksum is the same as used by Fiber Channel, and is therefore available 
> 'for free' in some, but not all, hardware, so there needs to be another way 
> to integrity protect the data.
> 
> Andrew
> 
> --On Wednesday, January 08, 2003 11:10:44 -0800 "H. Peter Anvin" 
> <hpa@zytor.com> wrote:
> 
> > Followup to:  <20030107053146.A16578@kerberos.ncsl.nist.gov>
> > By author:    Olivier Galibert <galibert@pobox.com>
> > In newsgroup: linux.dev.kernel
> >>
> >> On Tue, Jan 07, 2003 at 01:39:38PM +1300, Andrew McGregor wrote:
> >> > Ethernet and TCP were both designed to be cheap to evaluate, not the
> >> > absolute last word in integrity.  There is a move underway to provide
> >> > an  optional stronger TCP digest for IPv6, and if used with that then
> >> > there is  no need for the iSCSI digest.  Otherwise, well, play dice
> >> > with the data.  Loaded in your favour, but still dice.
> >>
> >> Ethernet's checksum is a standard crc32, with all the usual good
> >> properties and, at least on FE and lower, 1500bytes max of payload.
> >> So it's quite reasonable.  TCP's checksum, though, is crap.
> >>
> >> I'm not entirely sure how crc32 would behave on jumbo frames.
> >>
> >
> > AUTODIN-II CRC32 (the one used by Ethernet) is stable up to 11454
> > bytes.  The jumbo frame size was chosen as the largest multiple of the
> > standard IP payload size to fit within this number.
> >
> > 	-hpa
> 
> -

The TCP/IP checksum is 'strange' in that if all 0x00 are changed to 0xff,
it will not detect the error. But... in the 'real world', the TCP/IP
checksum does quite well detecting the kinds of errors likely in
serial links. Many years ago, in one of our products, some 'junior'
designer once decided that the way to control some equipment would be to
use RS-232C. Nobody at the design reviews caught this. RS-232C is about
99.999 percent reliable. That means that one byte in 10,000 may be
damaged. Normally humans correct RS-232C errors by looking at echo and
fixing the 'typo'. The product ran off a VAXen serial link at 19,200 baud,
the highest speed to which the VAX could be set.

The machine would not work. I ended up having to 'fix' the problem
in software. I used a TCP/IP checksum. The communications then never
failed (after the necessary retries). Since this was a 'success' I
decided to keep a record of the number of bad blocks retransmitted.

The customer got interested and emphatically stated; "The TCP/IP
checksum is wortless because.....". The result being pages of the
known anomolies of the checksum. The customer then required a
32-bit CRC they they specified. It was a standard polynominal,
but it was initialized with 0xaa55aa55 rather than 0xffffffff
(that's what then wanted). So, I used both and I logged the
operation of both.

There were never any errors, detected by the CRC, that were not
also detected by the checksum. This interface was for a spectrometer
that ran continuous serial commands (and data) for months at a time.
I recall that there were typically 40 to 50 recovered errors per
hour of operation. We delivered thousands of these.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


