Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272387AbRHYIFw>; Sat, 25 Aug 2001 04:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272392AbRHYIFm>; Sat, 25 Aug 2001 04:05:42 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:26636 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S272387AbRHYIF3> convert rfc822-to-8bit; Sat, 25 Aug 2001 04:05:29 -0400
Date: Sat, 25 Aug 2001 10:02:57 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <Pine.LNX.4.33L.0108242011110.31410-100000@duckman.distro.conectiva>
Message-ID: <20010825094000.O756-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Aug 2001, Rik van Riel wrote:

> On Fri, 24 Aug 2001, Gérard Roudier wrote:
>
> > The larger the read-ahead chunks, the more likely trashing will
> > occur. In my opinion, using more than 128 K IO chunks will not
> > improve performances with modern hard disks connected to a
> > reasonnably fast controller, but will increase memory pressure
> > and probably thrashing.
>
> Your opinion seems to differ from actual measurements
> made by Roger Larsson and other people.

The part of my posting that talked about modern hard disks sustaining more
than 8000 IOs per second and controllers sustaining 15000 IOs per second
is a _measurement_.

With such values, given a U160 SCSI BUS, using 64K IO chunks will result
in about less than 25% of bandwidth used for the SCSI protocol and 75% for
useful data at full load (about 2000 IO/s - 120 MB/s). This is a
_calculation_. With 128K IO chunks, less than 15% of the SCSI BUS will be
used for the SCSI protocol and more than 85% for usefull data. Still a
_calculation_.

This let me claim - opinion based on fairly simple calculations - that if
using more 128 K IO chunks gives significantly better throughput, then
some serious IO scheduling problem should exist in kernel IO subsystems.

> But yes, increasing the readahead window also increases
> the chance of readahead window thrashing. Luckily we can
> detect fairly easily if this is happening and use that
> to automatically shrink the readahead window...

Using too large buffering when it is not needed may lead to great penalty
everywhere, not only in kernel memory management. All caching entities in
the system hardware and devices will uselessly get pressure and will slow
down as a result.

Band-aiding scheduling flaws by using hudge bufferring is a fairly stupid
approach, in my opinion.

Regards,
  Gérard.

