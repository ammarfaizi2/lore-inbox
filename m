Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278665AbRKMTxG>; Tue, 13 Nov 2001 14:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRKMTw4>; Tue, 13 Nov 2001 14:52:56 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:36617 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S278649AbRKMTwk>; Tue, 13 Nov 2001 14:52:40 -0500
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: PATCH: scsi_scan.c: emulate windows behavior
Date: Tue, 13 Nov 2001 20:49:09 +0100
Organization: Cistron Internet Services B.V.
Message-ID: <9srtm6$8hf$1@ncc1701.cistron.net>
In-Reply-To: <20011113102106.A23110@one-eyed-alien.net>
X-Trace: ncc1701.cistron.net 1005681159 8751 213.46.44.164 (13 Nov 2001 19:52:39 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matthew Dharm" <mdharm-kernel@one-eyed-alien.net> wrote in message
news:cistron.20011113102106.A23110@one-eyed-alien.net...

>Attached is a one-liner patch to scsi_scan.c, which changes the length of
>the INQUIRY data request from 255 bytes to 36 bytes.  This subtle change
>makes Linux act more like Win/MacOS and other popular OSes, and reduces
>incompatibility with a broad range of out-of-spec devices that will simply
>die if asked for more than the required minimum of 36 bytes.

>Matt

Matt,

Many devices have useful information in the bytes beyond 36. Media changers from
various vendors are starting to use byte 55 bit 0 to flag if a barcode scanner
is present. Other devices have revision levels and/or serial numbers there.

Getting more than 36 bytes should not be a problem for any device. The root
problem seems to be that 255 is an odd number. On Wide-SCSI, a lot of devices
have difficulty handling odd byte counts as they have to use additional
messaging to flag the residue in the last 16-bit transfer. Also, the IDE-SCSI
layer has trouble, as the IDE spec doesn't allow odd byte transfers at all. I've
experienced issues with IDE devices that had to have their firmware patched just
to deal with the Linux odd-byte request. Maybe a better change would be to use
64 or 128 byte requests. Your thoughts?

Rob




