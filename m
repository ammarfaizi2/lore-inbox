Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSGaVEQ>; Wed, 31 Jul 2002 17:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSGaVEQ>; Wed, 31 Jul 2002 17:04:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33028 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317845AbSGaVEP>;
	Wed, 31 Jul 2002 17:04:15 -0400
Message-ID: <3D48511A.C31443A3@zip.com.au>
Date: Wed, 31 Jul 2002 14:05:30 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ATAPI CD-R lags system to hell burning in DAO mode; but not in TAO
References: <20020731203008.GA27702@vitelus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> 
> I've got a Teac CD-W524E 24x CD-R writer, and ever since I got it
> several months ago I have had the somewhat annoying issue that burning
> a cd Disc-At-Once makes the system unusable during the burn. The X
> cursor jerks, repaints take forever, etc. This problem doesn't occur
> when burning Track-At-Once - I'm unable to notice any significant
> increase in system latency when using that mode.
> 

This is presumably because the machine is full of memory which
is dirty against a slooow device.

You can work around this by reducing the dirty memory thresholds:

akpm-1:/home/akpm> cat /proc/sys/vm/bdflush
30      64      64      256     30000   3000    60      0       0

Make the "30" and "60" smaller.  10 and 20 perhaps.

Better: change the application to fsync() the data every few
megabytes, or open O_SYNC.

-
