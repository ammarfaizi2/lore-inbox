Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267897AbTAHUBH>; Wed, 8 Jan 2003 15:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267894AbTAHUBG>; Wed, 8 Jan 2003 15:01:06 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:50641 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267897AbTAHUBF>; Wed, 8 Jan 2003 15:01:05 -0500
Date: Thu, 09 Jan 2003 09:09:30 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <81050000.1042056570@localhost.localdomain>
In-Reply-To: <avht3k$qpo$1@cesium.transmeta.com>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
 <3E19B401.7A9E47D5@linux-m68k.org>
 <17360000.1041899978@localhost.localdomain>
 <20030107053146.A16578@kerberos.ncsl.nist.gov>
 <avht3k$qpo$1@cesium.transmeta.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, talking to some people off-list, I realised that what happened 
with the instances I saw was probably that the packets were corrupted 
inside the host, somewhere after the ethernet checksum had done its job. 
DMA problems or a slow address line on some RAM somewhere could easily beat 
the TCP checksum, but as many folks have pointed out, ethernet CRC is much 
stronger.

Having seen something odd like that in practice, I overestimated the 
probability of these problems.

It was also pointed out that iSCSI also makes it's CRC optional only if 
there is some other mechanism (ESP, AH or some other high-integrity 
transport) providing the data integrity.  Partly this is because that 
checksum is the same as used by Fiber Channel, and is therefore available 
'for free' in some, but not all, hardware, so there needs to be another way 
to integrity protect the data.

Andrew

--On Wednesday, January 08, 2003 11:10:44 -0800 "H. Peter Anvin" 
<hpa@zytor.com> wrote:

> Followup to:  <20030107053146.A16578@kerberos.ncsl.nist.gov>
> By author:    Olivier Galibert <galibert@pobox.com>
> In newsgroup: linux.dev.kernel
>>
>> On Tue, Jan 07, 2003 at 01:39:38PM +1300, Andrew McGregor wrote:
>> > Ethernet and TCP were both designed to be cheap to evaluate, not the
>> > absolute last word in integrity.  There is a move underway to provide
>> > an  optional stronger TCP digest for IPv6, and if used with that then
>> > there is  no need for the iSCSI digest.  Otherwise, well, play dice
>> > with the data.  Loaded in your favour, but still dice.
>>
>> Ethernet's checksum is a standard crc32, with all the usual good
>> properties and, at least on FE and lower, 1500bytes max of payload.
>> So it's quite reasonable.  TCP's checksum, though, is crap.
>>
>> I'm not entirely sure how crc32 would behave on jumbo frames.
>>
>
> AUTODIN-II CRC32 (the one used by Ethernet) is stable up to 11454
> bytes.  The jumbo frame size was chosen as the largest multiple of the
> standard IP payload size to fit within this number.
>
> 	-hpa

