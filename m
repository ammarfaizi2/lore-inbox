Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbSLXJKs>; Tue, 24 Dec 2002 04:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbSLXJKs>; Tue, 24 Dec 2002 04:10:48 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:23598 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S267079AbSLXJKr>; Tue, 24 Dec 2002 04:10:47 -0500
Date: Tue, 24 Dec 2002 10:18:52 +0100
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v548)
Cc: "'David Lang'" <dlang@diginsite.com>,
       "'Torben Frey'" <kernel@mailsammler.de>, <linux-kernel@vger.kernel.org>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
In-Reply-To: <000d01c2a8b6$3d102e20$941e1c43@joe>
Message-Id: <B7CC2AA8-1720-11D7-8DC6-000393950CC2@karlsbakk.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.548)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SHORT ANSWER: Segregating partitions reduces seek time.  Period.
>
> LONG ANSWER: Reads and writes tend to be grouped within a partition.  
> For
> example, if you're starting a program, you're going to be doing a lot 
> of
> reads somewhere in the /usr partition.  If the program uses temporary 
> files,
> you're going to do a lot of reads & writes in the /tmp partition.  If 
> you're
> saving a file, you're going to be doing lots of writes to the /home
> partition.  Hence, since most disk accesses occur in groups within a
> partition, preference should be giving to reducing seek time WITHIN a
> partition, rather than reducing seek time BETWEEN partitions.

keep in mind that only around half of the seek time is because of the 
partition! Taking an IBM 120GXP as an example:

Average seek:				8.5ms
Full stroke seek:			15.0ms
Time to rotate disk one round:	1/(7200/60)*1000 = 8.3ms

Then, the sector you're looking for, will, by average, be half a round 
away from where you are, and thus, giving the minimum average seek time 
8.3/2 = 4.15ms or something like half the seek time. Concidering this, 
you may gain a maximum <= 50% gain in using smaller partitions.

btw. anyone that knows the zone layout on IBM drives?

roy

