Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281407AbRKEWpM>; Mon, 5 Nov 2001 17:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281409AbRKEWpC>; Mon, 5 Nov 2001 17:45:02 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:48401 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281407AbRKEWot>; Mon, 5 Nov 2001 17:44:49 -0500
Message-ID: <3BE71529.F781EF2A@zip.com.au>
Date: Mon, 05 Nov 2001 14:39:37 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: disk throughput
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>,
		<3BE5F5BF.7A249BDF@zip.com.au> <20011105132346.B5805@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> 
> On Sun, 04 Nov 2001, Andrew Morton wrote:
> 
> > Numbers.  The machine has 768 megs; the disk is IDE with a two meg cache.
> > The workload consists of untarring, tarring, diffing and removing kernel
> > trees. This filesystem is 21 gigs, and has 176 block groups.
> 
> Does that IDE disk run with its write cache enabled or disabled?

write-behind is enabled.  I'm not religious about write-behind.
Yes, there's a small chance that the disk will decide to write a
commit block in front of the data (which is at lower LBAs).  But

a) It's improbable
b) if it does happen, the time window where you need to crash
   is small.
c) if your kernel crashes, the data will still be written.  It
   has to be a power-down.

But good point - I'll test without writebehind, and with SCSI.

-
