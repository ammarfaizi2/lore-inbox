Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTEMUb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbTEMUb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:31:28 -0400
Received: from mcomail02.maxtor.com ([134.6.76.16]:48401 "EHLO
	mcomail02.maxtor.com") by vger.kernel.org with ESMTP
	id S263451AbTEMUa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:30:56 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D347@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Andre Hedrick'" <andre@linux-ide.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Dave Jones <davej@codemonkey.org.uk>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: RE: 2.5.69, IDE TCQ can't be enabled
Date: Tue, 13 May 2003 14:43:50 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
>From: Andre Hedrick [mailto:andre@linux-ide.org]
>Sent: Tuesday, May 13, 2003 2:29 PM
>To: Jeff Garzik
>Cc: Jens Axboe; Dave Jones; Mudama, Eric; Oleg Drokin; Bartlomiej
>Zolnierkiewicz; Alan Cox; Oliver Neukum; lkhelp@rekl.yi.org;
>linux-kernel@vger.kernel.org
>Subject: Re: 2.5.69, IDE TCQ can't be enabled
>
>This is the last time I got TAG running clean!
>Proof you have zero gain on writes and huge gains on reads.

Of course there's no gain on writes with write cache enabled, that is
obvious:

It is nearly impossible for a drive to cache random reads, therefore they
have the greatest performance penalty due to seeks and rotational latency.
That is why queueing improves random reads so much.

Repetitive and Sequential reads should see no benefit at all from queueing,
since the virtually-zero-size drive cache actually hits its locality
(spatial or temporal) cases for these commands.

Similarly, any write with the drive's write cache enabled will see zero or
near-zero benefit from queueing writes.  The only reason to use queued
writes is so you can intermingle them with queued reads without flushing
your tags.

If you disable write cache on the drive (Journalling/RAID environments) then
you'll see performance nearly identical to reads, which then can benefit by
queueing to the same degree.

>Still it is a lame protocol.

I don't necessarilly disagree, however I'm not on T13 and didn't have any
input.

--eric
