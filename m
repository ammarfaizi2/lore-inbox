Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbTA0P2W>; Mon, 27 Jan 2003 10:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbTA0P2V>; Mon, 27 Jan 2003 10:28:21 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:61328 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S267203AbTA0P2V> convert rfc822-to-8bit;
	Mon, 27 Jan 2003 10:28:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] fs/partitions/msdos.c Guard against negative sizes
Date: Mon, 27 Jan 2003 16:38:47 +0100
User-Agent: KMail/1.4.3
References: <UTC200301271203.h0RC3Sb19647.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200301271203.h0RC3Sb19647.aeb@smtp.cwi.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301271638.47142.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >             u32 size = NR_SECTS(p)*sector_size;
> > -           if (!size)
> > +           if (size <= 0)
>
> But an unsigned variable cannot be negative, so what you write
> is the same as what was there already.
>
> In other words, your "negative" sizes are just very large positive.
>
> The test should be whether the partition extends beyond the end
> of the disk, but sometimes that is allowed, even necessary, so
> there could be a warning only.
Sorry, didn't pay enough attention.
On second look: it's an u32.
But that brings the next question up: what about overflow? u32 means a max of 
4GB.
	u32 start = START_SECT(p)*sector_size;
	u32 size = NR_SECTS(p)*sector_size;
And this looks as if it was calculated in bytes - but I'm sure that 4GB is not 
the max size! Where am I wrong??

And btw, when can a partition that extends beyond the end be "allowed or even 
necessary"?


Thanks for your answer!


Regards,

Phil


