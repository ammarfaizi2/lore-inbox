Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTK2UGq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 15:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTK2UGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 15:06:46 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:16879 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S262683AbTK2UGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 15:06:44 -0500
Date: Sat, 29 Nov 2003 16:38:06 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Darren Dupre <darren@dmdtech.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "DV failed to configure device" for Quantum DLT4000 tape drive on Adaptec 2940UW, 2.6.0-test11
Message-ID: <20031129163806.A14451@mail.kroptech.com>
References: <009201c3b6a6$f8e7e800$1e01a8c0@dmdtech2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <009201c3b6a6$f8e7e800$1e01a8c0@dmdtech2>; from darren@dmdtech.org on Sat, Nov 29, 2003 at 12:31:14PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 12:31:14PM -0600, Darren Dupre wrote:
> I only use my Adaptec 2940-UW for doing weekly backups to my Quantum DLT4000
> (external) tape drive. On the 2.4 kernels, I'd just modprobe aic7xx and it
> would detect the tape drive, load the st module and I could do my usual tar
> command to backup stuff to tape. On 2.6.0-test11, I modprobe aic7xxx and it
> detects the drive but it says "scsi0:A:5:0: DV failed to configure device.
> Please file a bug report against this driver." and the st module does not
> get loaded.
> 
> Not sure what this means.. I didnt have this problem with 2.4.21.
> 
> However, I can modprobe st and use the tape drive just fine.

I've seen this same issue with my Quantum DLT4000 & 2940UW as well. It
seems to have to do with there being a tape in the drive when the
aic7xxx driver initializes. It looks to me like the DLT4000 does not
respond to the DV configuration attempt when it is in the middle of
rewinding a tape. If the rewind takes long enough, aic7xxx times out the
configuration and gives the message you saw. 

I run a completely static kernel so in my case the problem happens when
I reboot the machine with a tape still in the drive and the tape is
positioned near the end. When the 2940UW BIOS initializes it triggers
the DLT4000 to start rewinding the tape and if the tape is positioned
far enough along it can still be rewinding when the kernel boots and 
aic7xxx tries to perform the DV configuration.

--Adam

