Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276172AbRI1RBT>; Fri, 28 Sep 2001 13:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276170AbRI1RBK>; Fri, 28 Sep 2001 13:01:10 -0400
Received: from [217.6.75.131] ([217.6.75.131]:8941 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S276175AbRI1RBG>; Fri, 28 Sep 2001 13:01:06 -0400
Message-ID: <3BB4AEEC.ECE9DDBD@internetwork-ag.de>
Date: Fri, 28 Sep 2001 19:10:04 +0200
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: tip@prs.de, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: 2.4.10 lockup using ppp on SMP
In-Reply-To: <3BB4912A.414B809A@internetwork-ag.de> <20010928184246.M1731@gum01m.etpnet.phys.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, forgot to tell - Chris Mason's patch has been applied (so NO change).
The problem seems somhow related to the general kernel lock in ioctls - to prove I
commented the unlock_kernel()/lock_kernel() in sock_ioctl out, leaving the kernel
locked during socket ioctls - bad, but proves ioctl related locking problem in
ppp_generic.c... The problem has nothing to do w/ double frees or mem. corruption
(IMO) - it seems to be related to "rest of the spin lock abuses" in ppp_generic.c...
:-)

Thanks for your help

Immanuel
Kurt Garloff wrote:

> On Fri, Sep 28, 2001 at 05:03:06PM +0200, Till Immanuel Patzschke wrote:
> > Hi,
> >
> > 2.4.10 (and all its 2.4.x predecessors) lock up in ppp_destroy_interface. Thanks
> > to the kdb I got the two tracebacks below - the all_ppp_lock interferes with
> > some other (socket?!) lock...
> > Any help is VERY much appreciated!
>
> Please try the patch that Chris Mason sent to LKML a day ago.
>
> Regards,
> --
> Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
> GPG key: See mail header, key servers         Linux kernel development
> SuSE GmbH, Nuernberg, DE                                SCSI, Security
>
>   --------------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



