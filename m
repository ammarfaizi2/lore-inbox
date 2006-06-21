Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751998AbWFUJVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbWFUJVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWFUJVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:21:18 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:9601 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751993AbWFUJVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:21:17 -0400
Date: Wed, 21 Jun 2006 05:17:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Infinite interrupt loop, INTSTAT = 8 ( WAS:  BUG:
  spinlock recursion on CPU,
To: Konstantin Antselovich <konstantin@antselovich.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606210520_MC3-1-C307-8E0E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44971B43.7090802@antselovich.com>

On Mon, 19 Jun 2006 14:46:43 -0700, Konstantin Antselovich wrote:

> But other some problems evolved: when I take a HDD out then push it
> right back, kernel freezes and the following messages are logged:
> 
> ---(see detailed log in attachment)---
> Jun 19 13:52:05 192.168.0.201 Infinite interrupt loop, INTSTAT = 8
> Jun 19 13:52:05 192.168.0.201 scsi0: At time of recovery, card was paused
> Jun 19 13:52:05 192.168.0.201 >>>>>>>>>>>>>>>>>> Dump Card State Begins
> <<<<<<<<<<<<<<<<<
> Jun 19 13:52:05 192.168.0.201 scsi0: Dumping Card State at program
> address 0x0 Mode 0x33
> Jun 19 13:52:05 192.168.0.201 Card was paused

Sorry, can't help with that.

You should try:

        echo 'scsi remove-single-device 0 1 2 3' >/proc/scsi/scsi

where you replace the example numbers with:

        0 = host adapter number
        1 = host channel number
        2 = device SCSI id
        3 = device lun

before removing the device.  Then do:

        echo 'scsi add-single-device 0 1 2 3' >/proc/scsi/scsi

after putting it back.

To see your host adapter numbers, do:

        cat /proc/scsi/scsi


> After some more scsi messages are logged, other issue with networking
> pops up (see below).  At that point top shows 100% CPU is taken by event
> kernel thread, machine locks and I had to push restart.

Try posting this separately to netdev@vger.kernel.org.  I don't think it
should happen.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
