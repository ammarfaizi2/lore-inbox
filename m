Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130849AbQJ1QKe>; Sat, 28 Oct 2000 12:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130892AbQJ1QKY>; Sat, 28 Oct 2000 12:10:24 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:12688 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130849AbQJ1QKG>; Sat, 28 Oct 2000 12:10:06 -0400
Date: Sat, 28 Oct 2000 09:01:45 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: kernel BUG at slab.c:804!
To: reiserc@fs.tum.de
Cc: linux-kernel@vger.kernel.org
Message-id: <004f01c040f8$5fe05ba0$6500000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="Windows-1252"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd guess this is because of a bug that crept into test9,
where a TD is now leaked ... you can get rid of the slab
BUG warning by commenting out the line at the top of
drivers/usb/usb-ohci.c that #defines OHCI_MEM_SLAB.

That TD leak prevents the kmem_cache from getting freed,
and hence prevents that module from getting reloaded.

It was a mistake to leave that #defined at this time,
though of course it _ought_ to be fine to do that.

- Dave




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
