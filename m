Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUELW3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUELW3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUELW3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:29:18 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:19656 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261551AbUELW3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:29:16 -0400
Message-ID: <40A2A4D8.8080806@keyaccess.nl>
Date: Thu, 13 May 2004 00:27:36 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
References: <fa.jr282gn.1ni2t37@ifi.uio.no> <008201c437e7$b1a35160$6601a8c0@northbrook> <20040512185224.GA2658@bounceswoosh.org> <200405122305.47874.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405122305.47874.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> The other part of the story is a nasty bug in ide-disk.c driver:
> 
> write_cache() is called with (drive->id->cfs_enable_2 & 0x300) as argument
> 'arg' of type 'int' and then this value is assigned to the 'drive->wcache'
> of type 'unsigned char' so drive->wcache == 0 because 0x3000 gets truncated.
> 
> This bug has been present since introduction of drive->wcache (2.5.3),
> therefore we have never handled cache flush correctly before and never
> hit '& 0x2400' problem before.
> 
> Linus & Alan, you were almost right after all, drive->wcache was almost
> always zero for normal disks before 2.6.6.  It could be forced by user but
> only for disks having ATA-6 cache flush bits and was auto-set but only for
> removable disks (after Alan's fixes in 2.6.65).  You lucky b*st*rds.  ;-)
> 
> Rene, that's why wcache is 0 in /proc/ide/hdX/settings for older kernels
> or with my 'bandaid' fixes for 2.6.6.  'hdparm -W1' should work but only on
> quite recent drives (having ATA-6 bits).  However I don't know why you get
> regression in tiobench, we still need to explain this.

I'm afraid I can explain it. Even though hdparm -W0/-W1 didn't show up 
in the settings, they certainly do take effect (on this drive). The bad 
results I posted appear to have been with -W0. By default, and after 
-W1, it's back up to normal again. Sorry if I confused the issue.

Rene.
