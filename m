Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290645AbSBOTIy>; Fri, 15 Feb 2002 14:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290652AbSBOTIo>; Fri, 15 Feb 2002 14:08:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7179 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290645AbSBOTIa>;
	Fri, 15 Feb 2002 14:08:30 -0500
Message-ID: <3C6D5C6E.78047200@zip.com.au>
Date: Fri, 15 Feb 2002 11:07:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Kirby <sim@netnation.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: fsync delays for a long time.
In-Reply-To: <Pine.SGI.4.31.0202140951330.3076325-100000@fsgi03.fnal.gov> <E16bPqi-0000c5-00@the-village.bc.nu> <3C6C2342.5044B738@zip.com.au>,
		<3C6C2342.5044B738@zip.com.au> <20020215172436.GA6842@netnation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby wrote:
> 
> Not sure if this is related, but I still can't get 2.4 or 2.5 kernels to
> actually read and write at the same time during a large file copy between
> two totally separate devices (eg: from hda1 to hdc1).  "vmstat 1" shows
> reads with no writing for about 6-8 seconds followed by writes with no
> reading for about 5-6 seconds, repeat.

That's different.

It tends to be the case that when the dirty-data-generator hits
a particular threshold, it blocks while we write out vast amounts
of data.  So the throughput is very lumpy.

It's probable that it can be tamed a bit by fiddling with the
/proc/sys/vm/bdflush parameters. 

> Is there a patch available that could fix this?

The -aa patches fiddle extensively with the bdflush thresholds and logic.
There's stuff in there which might addresses this.

-
