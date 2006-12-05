Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031239AbWLEUMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031239AbWLEUMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031249AbWLEUMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:12:55 -0500
Received: from pat.uio.no ([129.240.10.15]:35782 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031239AbWLEUMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:12:54 -0500
Subject: Re: Mounting NFS root FS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Janne Karhunen <Janne.Karhunen@gmail.com>, MrUmunhum@popdial.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612052059010.18570@yvahk01.tjqt.qr>
References: <4571CE06.4040800@popdial.com>
	 <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com>
	 <1165246177.711.179.camel@lade.trondhjem.org>
	 <200612041912.30527.Janne.Karhunen@gmail.com>
	 <Pine.LNX.4.61.0612042100570.29300@yvahk01.tjqt.qr>
	 <1165265229.5698.21.camel@lade.trondhjem.org>
	 <Pine.LNX.4.61.0612051939180.18570@yvahk01.tjqt.qr>
	 <1165347465.5742.88.camel@lade.trondhjem.org>
	 <Pine.LNX.4.61.0612052059010.18570@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 15:12:45 -0500
Message-Id: <1165349565.5742.104.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.787, required 12,
	autolearn=disabled, AWL 1.21, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 20:59 +0100, Jan Engelhardt wrote:
> >> >> ./run_init -c /mnt /sbin/init; # or similar
> >> >> 
> >> >> And you can also start locking after pivot_rooting to /mnt, that would 
> >> >> not even require (/mnt)/var/lib/nfs to be a separate mount.
> >> >
> >> >Much better idea. You can delay starting rpc.statd until you have set up
> >> >your filesystem provided that you are not running any programs that
> >> >require NLM locking. If you do need to run such a program before you
> >> >start rpc.statd, then you will have to use the '-onolock' mount option.
> >> 
> >> Since we're on the topic locking, is it because I am not running
> >> statd on the client that my NFS client hangs during boot phase?
> >
> >If you have applications that try to set locks before rpc.statd is up
> >and running, then that would explain it.
> 
> Even if the nfs mount is mounted using -o ro,nolock?

No. The 'nolock' option means that the NFS client will use the VFS posix
locks only, which will not depend on rpc.statd.

Trond

