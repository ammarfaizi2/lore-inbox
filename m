Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317300AbSG1Uh6>; Sun, 28 Jul 2002 16:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317304AbSG1Uh6>; Sun, 28 Jul 2002 16:37:58 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:10493 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S317300AbSG1Uh5>; Sun, 28 Jul 2002 16:37:57 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Ed Sweetman" <safemode@speakeasy.net>,
       "Rik van Riel" <riel@conectiva.com.br>
Cc: "Ville Herva" <vherva@niksula.hut.fi>,
       "Linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
Date: Sun, 28 Jul 2002 13:42:10 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECEEBGDAAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1027885641.4228.143.camel@psuedomode>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2002-07-28 at 15:29, Rik van Riel wrote:
>> On 28 Jul 2002, Ed Sweetman wrote:
>>
>> > If you bother to do any real tests you'd see that linux will swap when
>> > nothing is going on and this doesn't hinder anything.
>>
>> Linux only puts pages in swap when it's low on free physical memory.

>Perhaps, but linux considers disk cache as "in use" memory and most
>people would consider it free memory that's just temporarily being taken
>advantage of "in case".  Linux will still swap even if 60% of ram is
>filesystem cache. I dont have a problem with it, was just stating some
>real observations.

I don't remember anyone implying that pages in memory that are backed by a
named file on a filesystem are "free memory" in Linux or Solaris.
If you thought you read this you should traverse the thread again.
The discussion was centered around whether it would "add value" to
preference filesystem
pages over anonymous and executable pages when you reach the point where you
have
to start looking for pages to reclaim because of a physical memory shortage.

By all means, Solaris will swap pages and eventually entire processes if it
needs to, it just tries
to grab the oldest filesystem pages first. If that's not working (memory
shortage is still getting
worse even though the scanner is running) it will reach the next watermark
which changes the behavior
of the scanner.

Another example of this kind of behavior is how the scanner in Solaris skips
over extensively shared libraries.
The scanner looks at the share reference count for each page and if the page
is shared more than
a certain amount (certain number of processes), then it is skipped during
the page scan operation.

Regards,

--Buddy

