Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTARRY2>; Sat, 18 Jan 2003 12:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTARRY2>; Sat, 18 Jan 2003 12:24:28 -0500
Received: from [81.2.122.30] ([81.2.122.30]:45574 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264716AbTARRY1>;
	Sat, 18 Jan 2003 12:24:27 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301181733.h0IHXbkZ001932@darkstar.example.net>
Subject: Re: reading from devices in RAW mode
To: folkert@vanheusden.com (Folkert van Heusden)
Date: Sat, 18 Jan 2003 17:33:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004d01c2bf14$54099340$3640a8c0@boemboem> from "Folkert van Heusden" at Jan 18, 2003 06:09:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The closest you could probably get with any modern device would be
> > "read sector foo, and return data even if ECC appears to have
> > failed".
> 
> And that's exactly what I want!
> (for the situations where the bad data starts, say, halfway the sector)

You'd have to ask the IDE and SCSI subsystem people for programming
information about how to do that for disks.

The problem is that as far as I know, if the ECC doesn't work, you
won't end up getting back back more or less intact data, with just a
flipped bit here and there.

I'm not sure exactly how it works, but the basic theory is something
along these lines:

Suppose you are storing 5 data bits using 10 actual bits on disk.

Typically, you might expect a read to read to return 8 bits accurately
and 2 bits inaccurately.  That's enough to re-construct the data.
When 6 bits are read inaccurately, an un-correctable error occurs.
Retrying the read might succeed, because only 4 bits might be read
inaccurately the second time.

Although reading without using error correction will allow you to
access the unreadable data, is quite likely to return some of the 5
data bits incorrectly, which could have been corrected, incorrectly.

I hope that explaination is of some use - maybe somebody else can
improve it.

John.
