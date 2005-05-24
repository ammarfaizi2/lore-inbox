Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVEXJZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVEXJZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVEXJX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:23:58 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:30148 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261994AbVEXJS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:18:57 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091855.DBC2AF9EC@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:18:55 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 44195FB75

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:47 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261384AbVEXHNP (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 03:13:15 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVEXHNO

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 03:13:14 -0400

Received: from ns9.hostinglmi.net ([213.194.149.146]:41633 "EHLO

	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261384AbVEXHMt

	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 03:12:49 -0400

Received: from 212.red-80-35-44.pooles.rima-tde.net ([80.35.44.212] helo=localhost)

	by ns9.hostinglmi.net with esmtpa (Exim 4.44)

	id 1DaTaF-0006fs-QT; Tue, 24 May 2005 09:12:12 +0200

Date:	Tue, 24 May 2005 09:14:07 +0200

From: DervishD <lkml@dervishd.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] Hard disk LBA sector count is not always the same

Message-ID: <20050524071407.GA60@DervishD>

Mail-Followup-To: Petr Vandrovec <vandrove@vc.cvut.cz>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050523121424.GB339@DervishD> <42922175.8090005@pobox.com> <20050523200221.GE57@DervishD> <42925760.9010603@vc.cvut.cz>

Mime-Version: 1.0

Content-Type: text/plain; charset=iso-8859-1

Content-Disposition: inline

In-Reply-To: <42925760.9010603@vc.cvut.cz>

User-Agent: Mutt/1.4.2.1i

Organization: DervishD

X-AntiAbuse: This header was added to track abuse, please include it with any abuse report

X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net

X-AntiAbuse: Original Domain - vger.kernel.org

X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]

X-AntiAbuse: Sender Address Domain - dervishd.net

X-Source: 

X-Source-Args: 

X-Source-Dir: 

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org

Content-Transfer-Encoding: quoted-printable



    Hi Petr :)

    Thanks for your answer :)

 * Petr Vandrovec <vandrove@vc.cvut.cz> dixit:
> >>DervishD wrote:
> >>>  current capacity is 156299375
> >>>  native capacity is 156301488
> >>Hard drives have a feature that can reserve a certain amount of space=
=20
> >>away from the user.
> >    Yes, I know, but the problem is that 2.4 kernels *does* reserve
> >that space but 2.6 certainly not, and if I boot into 2.6 and then
> >reboot into 2.4, then 2.4 *does NOT* reserve that space.
> Yes.  It is normal...

    I'm surprised :??? Does 2.6 'stroking' by default? I supposed
that maybe Debian people had activated stroking...
=20
> >    See the paragraph above: if I partition the disk under 2.6 the
> >partition will have a bigger address than the one that will be
> >available under 2.4, and that can give errors while accessing that
> >extra sectors. What can I do? For technical limitations in my box, I
> >have to use 2.6 for repartitioning that disk (and I will be doing
> >that in less than a month) and this will lead to unaccesible sectors
> >when I boot back into my usual 2.4 kernel :(
> (1) You do not have to create partition over full disk.

    I would prefer to do it. Otherwise I have to calculate where the
partition must end in order to not disturb the kernel. Moreover, in
that space will go the swap partition, probably...
=20
> (2) If you'll build your 2.4.x kernel with CONFIG_IDEDISK_STROKE=3Dy
> ('Auto-Geometry Resizing support'), I bet that your problems with 2.4.x
> kernels disappear.

    I'll try right now... YES, it works!. I don't understand, my BIOS
is AMI, not Awards, and I assumed that the stroke option was used
only for Awards BIOS'es. I've looked at the code in the kernel and it
doesn't seem to be particular for Award :?? It should be specified in
the documentation.

    Thanks a lot for your suggestion and for solving my problem :)

    Ra=FAl N=FA=F1ez de Arenas Coronado

--=20
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

