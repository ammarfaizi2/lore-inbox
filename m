Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281381AbRKUWPc>; Wed, 21 Nov 2001 17:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKUWPY>; Wed, 21 Nov 2001 17:15:24 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:27520 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281381AbRKUWPH>; Wed, 21 Nov 2001 17:15:07 -0500
Message-ID: <001b01c172d9$d9de9fc0$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Kai Makisara" <Kai.Makisara@kolumbus.fi>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111212349540.5548-100000@kai.makisara.local>
Subject: Re: st.c SCSI Tape ioctl() bug
Date: Wed, 21 Nov 2001 15:14:13 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Kai.  You may want to check the default settings of these flags.  We
did notice that for whatever reaosn, when theyn get out of sync it's related
ot this problem.  However, the fix I did to the code appeared to cause
breakage of other areas.  Clearly a task better left to you.

Jeff

----- Original Message -----
From: "Kai Makisara" <Kai.Makisara@kolumbus.fi>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 21, 2001 2:58 PM
Subject: Re: st.c SCSI Tape ioctl() bug


> On Sun, 18 Nov 2001, Jeff V. Merkey wrote:
>
> >
> >
> > Kai/Linux,
> >
> > The ioctl() function to enable/disable code 15 comrpession has
> > some problems.  I have a fix to the code, but it does not
> > always seem to work properly, so I think you should do this
> > review.
> >
> > If you call the ioctl() tape command from kernel space to
> > enable and disable **DEFAULT** compression (not MTCOMPRESSION
> > ioctl, the MT_ST_DEF_COMPRESSION code path) there is a case
> > where the default_compression/compression_changed flags
> > can horribly out of sync.
> >
> > Please take a look at this code.  We have gotten around it
> > by simply calling MTCOMPRESSION everytime we need to use it,
> > however, but the other path seems busted, and it would be
> > nice for it to work properly.
> >
> The default compression is meant to be set only at system
> startup/module loading. If the user wants to change the compression at any
> other time, using MTCOMPRESSION is the correct way.
>
> However, I agree that setting the default compression at any other time
> should also give the expected result. Currently, the compression default
> will be enforced when a new tape is inserted. It might be better to change
> the compression immediately after the default has been changed if the
> drive is ready. This should also synchronize the compression_changed flag.
> I will think about this a little more and then make the changes.
>
> Kai
>

