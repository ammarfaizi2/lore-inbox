Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbSL3D7b>; Sun, 29 Dec 2002 22:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266678AbSL3D7b>; Sun, 29 Dec 2002 22:59:31 -0500
Received: from [209.195.52.121] ([209.195.52.121]:22244 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S266682AbSL3D73>; Sun, 29 Dec 2002 22:59:29 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Jeff Dike <jdike@karaya.com>
Cc: Werner Almesberger <wa@almesberger.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rik van Riel <riel@conectiva.com.br>,
       Anomalous Force <anomalous_force@yahoo.com>, ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 29 Dec 2002 19:55:24 -0800 (PST)
Subject: Re: holy grail 
In-Reply-To: <200212300245.VAA04199@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0212291948060.14400-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Dec 2002, Jeff Dike wrote:

> Step 3 is obviously where the meat of the problem is.  The process needs
> to have available on it all the resources it had in UML -
> 	the same files
> 	network connections (puntable on a first pass)
> 	process relationships (I have no idea what to do about a parent
> process on the host, nor what to do with children whose parent has been
> migrated, or ipc mechanisms, except to do the Mosix thing and have little
> proxies sitting around passing information between UML and the host).

I think people are at the point of working on this becouse it sounds like
a worthwhile feature, not becouse it's actually anything that would be
used.

what possible application needs to be able to do a seamless kernel upgrade
that wouldn't be useing a network?

if it's a batch processing task, it can checkpoint itself and restart
after a reboot.

if it's a controller of specialized equipment then you either can have the
process checkpoint itself, or you can't afford to pause long enough to do
the kernel swap (i.e. the device keeps operating regardless and so may
generate ssignals to the program during the time when you are swapping
kernels)

As Alan Cox said, anyone really needing this will have redundant systems
anyway (to cover the case of hardware failure) so they will already be
dealing with things on a cluster leveel and rebooting a machine to
complete the upgrade will not be that bad (they upgrade the backup, reboot
it, sync things up, failover to the backup, upgrade and reboot the primary
and keep running on the backup until the next upgrade cycle)

David Lang
