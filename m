Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbTAGAc3>; Mon, 6 Jan 2003 19:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267289AbTAGAc3>; Mon, 6 Jan 2003 19:32:29 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:3549 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267288AbTAGAc1>; Mon, 6 Jan 2003 19:32:27 -0500
Date: Tue, 07 Jan 2003 13:39:38 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Roman Zippel <zippel@linux-m68k.org>,
       Andre Hedrick <andre@pyxtechnologies.com>
cc: Oliver Xymoron <oxymoron@waste.org>, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <17360000.1041899978@localhost.localdomain>
In-Reply-To: <3E19B401.7A9E47D5@linux-m68k.org>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
 <3E19B401.7A9E47D5@linux-m68k.org>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.  The problem here is that there is a nontrivial probability that a 
packet can pass both ethernet and TCP checksums and still not be right, 
given the gigantic volumes of data that iSCSI is intended to be used with. 
Back up a 100 terabyte array and it's more than 1%, back of the envelope.

Ethernet and TCP were both designed to be cheap to evaluate, not the 
absolute last word in integrity.  There is a move underway to provide an 
optional stronger TCP digest for IPv6, and if used with that then there is 
no need for the iSCSI digest.  Otherwise, well, play dice with the data. 
Loaded in your favour, but still dice.

Andrew

--On Monday, January 06, 2003 17:51:13 +0100 Roman Zippel 
<zippel@linux-m68k.org> wrote:

> Hi,
>
>> If you know anything about iSCSI RFC draft and how storage truly works.
>> Cisco gets it wrong, they do not believe in supporting the full RFC.
>> So you get ERL=0, and now they turned of the "Header and Data Digests",
>> this is equal to turning off the iCRC in ATA, or CRC in SCSI between the
>> controller and the device.  For those people who think removing the
>> checksum test for the integrity of the data and command operations, you
>> get what you deserve.
>
> Ever heard of TCP checksums? Ever heard of ethernet checksums? Which
> transport doesn't use checksums nowadays? The digest makes only sense if
> you can generate it for free in hardware or for debugging, otherwise
> it's only a waste of cpu time. This makes the complete ERL 1 irrelevant
> for a software implementation. With block devices you can even get away
> with just ERL 0 to implement transparent recovery.
>
> bye, Roman
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


