Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267489AbUHSW6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267489AbUHSW6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267493AbUHSW6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:58:34 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5041 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267489AbUHSW6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:58:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Fri, 20 Aug 2004 00:57:55 +0200
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <1092938773.28350.27.camel@localhost.localdomain> <4124FD46.8040109@rtr.ca>
In-Reply-To: <4124FD46.8040109@rtr.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408200057.55050.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 21:19, Mark Lord wrote:
>  >And what do you do the day someone posts "lock IDE drive with random
>  >password as any user" to bugtraq ?
>
> I should hope that these lines in the driver would prevent such:
>
>        if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>              return -EACCES;

Exactly.

Sending raw commands is _privileged_ operation.

Alan's example is invalid because IDE driver requires CAP_SYS_ADMIN and 
CAP_SYS_RAWIO so if there is some security risk involved - it is in the user 
apps not in the kernel.  Also Linus first fixed SG_IO correctly with 
requiring CAP_SYS_RAWIO but then (under Alan's influence?) he added filtering 
which broke cd writing and which is just unmaintainable.

Also filtering cannot work in all cases because there are vendor specific 
opcodes, some devices redefines some opcodes etc. - this should be left to 
user space.

Bartlomiej
