Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967016AbWLDUrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967016AbWLDUrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967111AbWLDUrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:47:20 -0500
Received: from pat.uio.no ([129.240.10.15]:35702 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967016AbWLDUrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:47:19 -0500
Subject: Re: Mounting NFS root FS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Janne Karhunen <Janne.Karhunen@gmail.com>, MrUmunhum@popdial.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612042100570.29300@yvahk01.tjqt.qr>
References: <4571CE06.4040800@popdial.com>
	 <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com>
	 <1165246177.711.179.camel@lade.trondhjem.org>
	 <200612041912.30527.Janne.Karhunen@gmail.com>
	 <Pine.LNX.4.61.0612042100570.29300@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 15:47:09 -0500
Message-Id: <1165265229.5698.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.897, required 12,
	autolearn=disabled, AWL 1.10, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 21:03 +0100, Jan Engelhardt wrote:
> >> 2) NFS provides persistent storage.
> >
> >To me this sounds like a chicken and an egg problem. It 
> >both depends and provides this at the same time :/. But 
> >hey, if it's supposed to work then OK.
> 
> Way 1:
> 
> mount -nt tmpfs none /var/lib/nfs;
> mount -nt nfs fserve:/tftpboot/linux /mnt;
> mount -n --move /var/lib/nfs /mnt/var/lib/nfs/;

Nope. As Janne implied, the /var/lib/nfs partition _must_ be persistent,
since it is used to store information about the servers on which the
client holds locks and therefore needs to notify in case it reboots.
Using tmpfs defeats the whole purpose of having an rpc.statd in the
first place.

> ./run_init -c /mnt /sbin/init; # or similar
> 
> And you can also start locking after pivot_rooting to /mnt, that would 
> not even require (/mnt)/var/lib/nfs to be a separate mount.

Much better idea. You can delay starting rpc.statd until you have set up
your filesystem provided that you are not running any programs that
require NLM locking. If you do need to run such a program before you
start rpc.statd, then you will have to use the '-onolock' mount option.

Cheers,
  Trond

