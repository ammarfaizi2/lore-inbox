Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285032AbRLQHCV>; Mon, 17 Dec 2001 02:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285034AbRLQHCK>; Mon, 17 Dec 2001 02:02:10 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:63401 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S285032AbRLQHCA>; Mon, 17 Dec 2001 02:02:00 -0500
Date: Mon, 17 Dec 2001 00:01:56 -0700
Message-Id: <200112170701.fBH71uW04275@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. To followup on the change in 2.5.1 which sends a signal to
the signalling process when send_pid==-1, I have a definate case where
the new behaviour is highly undesirable, and I would say broken.

shutdown(8) from util-linux (*not* the version that comes with the
bloated monstrosity known as SysVInit) uses the sequence:
	kill (-1, SIGTERM);
	sleep (2);
	kill (-1, SIGKILL);

to ensure that all processes not stuck in 'D' state are killed.

With the new behaviour, shutdown(8) ends up killing itself. This is no
good, because the shutdown process doesn't complete (i.e. unmounting
of filesystems, calling sync(2) and good stuff like that).

If this change remains, it will break all users of
simpleinit(8)/shutdown(8). I'm not happy about moving logic for
shutdown(8) into simpleinit(8), since it will just end up bloating it
without good reason.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
