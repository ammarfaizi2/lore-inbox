Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbTK3QU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbTK3QU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:20:29 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38082 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264930AbTK3QU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:20:27 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Subject: Re: Silicon Image 3112A SATA trouble
Date: Sun, 30 Nov 2003 17:21:41 +0100
User-Agent: KMail/1.5.4
Cc: Jeff Garzik <jgarzik@pobox.com>, marcush@onlinehome.de, axboe@suse.de,
       linux-kernel@vger.kernel.org
References: <3FC36057.40108@gmx.de> <200311301547.32347.bzolnier@elka.pw.edu.pl> <3FCA1220.2040508@gmx.de>
In-Reply-To: <3FCA1220.2040508@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311301721.41812.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I read it _very_ closely, here is your original mail with subject
"Re: 2.6.0-test9 /-mm3 SATA siimage - bad disk performance":

On Saturday 15 of November 2003 10:11, Prakash K. Cheemplavam wrote:
> Marcus Hartig wrote:
> > Hello all,
> >
> > with the Fedora 1 kernel 2.4.22-1.2115.nptl I get with hdparm -t
> > (Timing buffered disk reads) 34 MB/sec. Its very slow for this drive.
> >
> > With 2.6.0-test9 and -mm3 I get around "62 MB in 3.05 = 20,31". Wow"
> > Back to ~1998?
>
> I have a similar problem: With 2.4.22-ac3 I had 37mb/sec with my Samsung
> HD and 49MB/sec with IBM/Hitachi, now with 2.6 (all I tried, including
                                    ^^^^^^^^^^^^
> test9-mm2) I had only 20mb/sec for Samsung and about 39mb/sec for the
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> IBM. Motherboard is Abit NF7-S Rev2.0, as well, so same situation with
  ^^^^
> the siimage 1.06 driver. I wanted to run some dd tests as well, but it 
> is a real performance hit. Playing with readahead or other hdparm
> options didn't help either.
>
> Prakash

In 2.6.x there is no max_kb_per_request setting in /proc/ide/hdx/settings.
Therefore
	echo "max_kb_per_request:128" > /proc/ide/hde/settings
does not work.

Hmm. actually I was under influence that we have generic ioctls in 2.6.x,
but I can find only BLKSECTGET, BLKSECTSET was somehow lost.  Jens?

Prakash, please try patch and maybe you will have 2 working drivers now :-).

--bart

On Sunday 30 of November 2003 16:52, Prakash K. Cheemplavam wrote:
> Bartlomiej Zolnierkiewicz wrote:
>  > Okay, stop bashing IDE driver... three mails is enough...
>  >
>  > Apply this patch and you should get similar performance from IDE driver.
>  > You are probably seeing big improvements with libata driver because
>
> you are
>
>  > using Samsung and IBM/Hitachi drives only, for Seagate it probably
>
> sucks just
>
>  > like IDE driver...
>  >
>  > IDE driver limits requests to 15kB for all SATA drives...
>  > libata driver limits requests to 15kB only for Seagata SATA drives...
>
> If you read my message closely then you should have understand that
> setting the request highr *didn't* help, ie
>
> echo "max_kb_per_request:128" > /proc/ide/hde/settings
>
> made *no* difference, so I won't even try that patch. As far I have
> understood this is exactly the thing you changed in the patch. If I am
> mistaken, then I take it back.
>
> Prakash

