Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318277AbSIBKuz>; Mon, 2 Sep 2002 06:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSIBKuz>; Mon, 2 Sep 2002 06:50:55 -0400
Received: from news.cistron.nl ([62.216.30.38]:25869 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S318265AbSIBKuy>;
	Mon, 2 Sep 2002 06:50:54 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: [PATCH] MODE SENSE in sd.c; sddr09.c
Date: Mon, 2 Sep 2002 13:00:39 +0200
Organization: Cistron
Message-ID: <akvg26$7nt$1@ncc1701.cistron.net>
References: <UTC200209020041.g820fGS22828.aeb@smtp.cwi.nl>
X-Trace: ncc1701.cistron.net 1030964102 7933 213.46.44.164 (2 Sep 2002 10:55:02 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Andries.Brouwer@cwi.nl> wrote in message
news:cistron.UTC200209020041.g820fGS22828.aeb@smtp.cwi.nl...
> In sd.c we call MODE SENSE (6) in order to find out whether the
> device is write protected. The info we need is in byte 2, the
> header of the MODE SENSE answer, but in the request we have to
> specify (i) what page(s) we want, and (ii) how many bytes we want.
>
> Long ago we asked for 12 bytes from page 1 (Daniel Roche, 1.3.35).
> Matthew Dharm made this 8 bytes from page 3F (all pages),
patch-2.4.0-test8.
> In patch-2.4.10 the 8 was increased to 255.
>
> I found on the one hand devices that only react to page 0
> (the vendor page), and return an error for page 3F.
> And on the other hand devices that are unable to handle requests
> for more bytes than they actually have.
>
> So, it seems that the cautious way to ask for MODE SENSE data is
> to first ask for the header only, see how much is available,
> and then ask for everything.
>
> The patch below first separates out the MODE SENSE call,
> and then tries it three times: on all pages (3F), only the first
> four bytes; on the vendor page (0), only the first four bytes;
> on all pages (3F), 255 bytes.
>

Andries,

Would it be possible to move away from using 'standard' 255 bytes? Many SCSI
device don't like requests for odd byte counts on 16-bit SCSI busses, and
IDE isn't too crazy about it either. How about asking for 254 instead??

Rob




