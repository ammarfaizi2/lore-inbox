Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968617AbWLESoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968617AbWLESoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968618AbWLESoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:44:46 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:60567 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968617AbWLESop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:44:45 -0500
Date: Tue, 5 Dec 2006 19:43:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Janne Karhunen <Janne.Karhunen@gmail.com>, MrUmunhum@popdial.com,
       linux-kernel@vger.kernel.org
Subject: Re: Mounting NFS root FS
In-Reply-To: <1165265229.5698.21.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.61.0612051939180.18570@yvahk01.tjqt.qr>
References: <4571CE06.4040800@popdial.com>  <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com>
  <1165246177.711.179.camel@lade.trondhjem.org>  <200612041912.30527.Janne.Karhunen@gmail.com>
  <Pine.LNX.4.61.0612042100570.29300@yvahk01.tjqt.qr>
 <1165265229.5698.21.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Way 1:
>> 
>> mount -nt tmpfs none /var/lib/nfs;
>> mount -nt nfs fserve:/tftpboot/linux /mnt;
>> mount -n --move /var/lib/nfs /mnt/var/lib/nfs/;
>
>Nope. As Janne implied, the /var/lib/nfs partition _must_ be persistent,
>since it is used to store information about the servers on which the
>client holds locks and therefore needs to notify in case it reboots.
>Using tmpfs defeats the whole purpose of having an rpc.statd in the
>first place.

Well, tmpfs is persistens as long as the machine is powered on (and
you did not manage to fubar the tmpfs etc.), no?

Or, you can also get it out of tmpfs again and restart statd once
you've pivoted.

>> ./run_init -c /mnt /sbin/init; # or similar
>> 
>> And you can also start locking after pivot_rooting to /mnt, that would 
>> not even require (/mnt)/var/lib/nfs to be a separate mount.
>
>Much better idea. You can delay starting rpc.statd until you have set up
>your filesystem provided that you are not running any programs that
>require NLM locking. If you do need to run such a program before you
>start rpc.statd, then you will have to use the '-onolock' mount option.

Since we're on the topic locking, is it because I am not running
statd on the client that my NFS client hangs during boot phase?


	-`J'
-- 
