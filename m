Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSEDUgS>; Sat, 4 May 2002 16:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315212AbSEDUgR>; Sat, 4 May 2002 16:36:17 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:30431 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S315210AbSEDUgQ>; Sat, 4 May 2002 16:36:16 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <Andries.Brouwer@cwi.nl>, <alan@lxorguk.ukuu.org.uk>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
Subject: RE: IO stats in /proc/partitions
Date: Sat, 4 May 2002 13:35:29 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBCEAOEMAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <UTC200205041959.g44JxQa20044.aeb@smtp.cwi.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm with Andries on this one! Linux can't survive if anyone can change it
and break all the supporting software in user space that reads stuff from
/proc. I'm all in favor of expanded performance statistics on I/O - I look
at that stuff for a living and *write* some of those supporting tools. If I
have to recode my performance monitoring tools every time someone gets a
bright idea and doesn't personally e-mail me about it, I won't have the time
to do detailed performance analysis.

Linux has *got* to mature to the point where the documentation is *accurate*
and *available* and the APIs don't wobble under the feet of their users. I
recently spent a week trying to track down the units used for the disk stats
in /proc/stat. Through a combination of queries on the LKML and trucking
through the source with rgrep, I managed to get my questions answered. It
matters to me and to the people I work for exactly how many bytes the I/O
subsystem is handling per second, and how close to the capacity of the I/O
subsystem a machine is operating. I consider the fact that I had to dig for
and ask for this information unacceptable.

Maybe I've said this before, but it bears repeating for those in the Linux
community that are not in a business situation: business is about time,
people and money. Business people in general don't optimize, they
*satisfice*. That is, the overwhelming market share goes not to the *best*
product but to the one that is good enough and saves people time or makes
people money. Something that wastes my time costs my employer money.
--
M. Edward Borasky
znmeb@borasky-research.net

The COUGAR Project
http://www.borasky-research.com/Cougar.htm

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
Andries.Brouwer@cwi.nl
Sent: Saturday, May 04, 2002 12:59 PM
To: alan@lxorguk.ukuu.org.uk; hpa@zytor.com; linux-kernel@vger.kernel.org;
marcelo@conectiva.com.br
Subject: Re: IO stats in /proc/partitions

Earlier I noticed that RedHat did put some statistics in
/proc/partitions. That was bad, but I assumed that it was
their laziness, being too busy to do a proper job.

However, I see that these days the pollution of /proc/partitions
is becoming official - it is part of patch-2.4.19-pre7.
I strongly object, and hope it is not too late to revert this.

Things must do one thing, and one thing well.
The task of /proc/partitions is to list which partitions the
kernel knows about. When I implemented it I thought that adding
the starting offset would be superfluous, but in fact I now realize
that that is required for several applications.
So, /proc/partitions must be updated sooner or later with an
additional field "starting offset". Possibly more fields to
enable identification. Sometimes it is really difficult to
determine which Linux name belongs to which hardware device,
especially with USB.

On the other hand, disk statistics should not be in
/proc/partitions. They should be in /proc/diskstatistics.
I see a heading today "rio rmerge rsect ruse wio wmerge"
"wsect wuse running use aveq". No doubt next year we'll
want different statistics. So /proc/diskstatistics should
start with a header line including a version field.

Please keep these disk statistics apart from /proc/partitions.

Andries

