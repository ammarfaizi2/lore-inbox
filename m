Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291759AbSCDFkf>; Mon, 4 Mar 2002 00:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291766AbSCDFk1>; Mon, 4 Mar 2002 00:40:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27399 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291759AbSCDFkS>;
	Mon, 4 Mar 2002 00:40:18 -0500
Message-ID: <3C830842.A00609FE@zip.com.au>
Date: Sun, 03 Mar 2002 21:38:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jon Masters <jonathan@jonmasters.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Loopback (2.4.18)
In-Reply-To: <Pine.LNX.4.10.10203040448130.2990-100000@router>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters wrote:
> 
> Hi,
> 
> I'm trying to use "multiCD" to backup around 3 lots of 25GB of data in to
> handy CD sized images. The software is a perl script which uses a loopback
> mounted file on which a standard ext2 filesystem with data is written,
> etc. I'm sure everyone gets the idea. These then get scp'd/burned.
> 

The loop driver does really naughty things which defeat the kernel's
management of dirty data.  It's quite easy to livelock machines with
it, especially if you increase the dirty buffer thresholds.

Alas, it's tricky.  I have three patches, none of which fix it.
Fourth time lucky, maybe.

I expect the problem will go away if you drop the dirty buffer
thresholds:

	echo 10 0 0 0 500 3000 25 0 0 > /proc/sys/vm/bdflush

Could you please try that?   Also, if/when it locks up again,
the SYSRQ-P information will be interesting.  Use the key
sequence several times, record the EIP values, look them up
after reboot.   Probably, they point at shrink_cache().

Thanks.

-
