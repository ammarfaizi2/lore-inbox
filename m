Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbTBPPO1>; Sun, 16 Feb 2003 10:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbTBPPO0>; Sun, 16 Feb 2003 10:14:26 -0500
Received: from fep07-0.kolumbus.fi ([193.229.0.51]:20969 "EHLO
	fep07-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S267081AbTBPPO0>; Sun, 16 Feb 2003 10:14:26 -0500
Date: Sun, 16 Feb 2003 17:25:22 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Ruud Linders <rkmp@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI Tape hangs when no tape loaded (2.5.6x)
In-Reply-To: <3E4F9D80.2000206@xs4all.nl>
Message-ID: <Pine.LNX.4.52.0302161710160.10784@kai.makisara.local>
References: <3E4F9D80.2000206@xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003, Ruud Linders wrote:

>
>
> On both 2.5.60 and 2.5.61 when there is no tape loaded in my SCSI DAT
> tape drive, access to the drive blocks for exactly 2 minutes
> before timing out and giving an I/O error.
>
> # mt stat
> ....... < 2 minutes later > ...
> /dev/tape: Input/output error
>
Does you mt open the tape device with the O_NONBLOCK option? If not, this
is what is expected. mt-st version >= 0.6 does use this option. I don't
know about other mt's.

The open() behaviour of st was changed at 2.5.3 to conform with SUS
(blocking) and what the other Unices do (timeout). If the device is opened
without O_NONBLOCK, the driver waits for some time (default 2 minutes) for
the device to become ready. If it does not become ready, an error is returned.

	Kai

P.S. I just tested 2.5.61 and in my system 'mt status' without tape in
the drive works as expected (i.e., prints status immediately).
