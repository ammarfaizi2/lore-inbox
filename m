Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281567AbRKUV6m>; Wed, 21 Nov 2001 16:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281711AbRKUV6W>; Wed, 21 Nov 2001 16:58:22 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:56790 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S281567AbRKUV6R>; Wed, 21 Nov 2001 16:58:17 -0500
Date: Wed, 21 Nov 2001 23:58:25 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: <makisara@kai.makisara.local>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: st.c SCSI Tape ioctl() bug
In-Reply-To: <20011118204819.A968@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.33.0111212349540.5548-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Jeff V. Merkey wrote:

>
>
> Kai/Linux,
>
> The ioctl() function to enable/disable code 15 comrpession has
> some problems.  I have a fix to the code, but it does not
> always seem to work properly, so I think you should do this
> review.
>
> If you call the ioctl() tape command from kernel space to
> enable and disable **DEFAULT** compression (not MTCOMPRESSION
> ioctl, the MT_ST_DEF_COMPRESSION code path) there is a case
> where the default_compression/compression_changed flags
> can horribly out of sync.
>
> Please take a look at this code.  We have gotten around it
> by simply calling MTCOMPRESSION everytime we need to use it,
> however, but the other path seems busted, and it would be
> nice for it to work properly.
>
The default compression is meant to be set only at system
startup/module loading. If the user wants to change the compression at any
other time, using MTCOMPRESSION is the correct way.

However, I agree that setting the default compression at any other time
should also give the expected result. Currently, the compression default
will be enforced when a new tape is inserted. It might be better to change
the compression immediately after the default has been changed if the
drive is ready. This should also synchronize the compression_changed flag.
I will think about this a little more and then make the changes.

	Kai


