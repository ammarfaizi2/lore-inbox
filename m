Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbRFCMe6>; Sun, 3 Jun 2001 08:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbRFCMJQ>; Sun, 3 Jun 2001 08:09:16 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:37599 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S262885AbRFCMAC>; Sun, 3 Jun 2001 08:00:02 -0400
Date: Sun, 3 Jun 2001 13:59:57 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Frazer <mark@somanetworks.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: MII access (was [PATCH] support for Cobalt Networks (x86 only)
In-Reply-To: <E156J4v-0002BA-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106031343530.31050-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jun 2001, Alan Cox wrote:

> > > Then it needs to be privileged
> >
> > Fine. Can you think of a default value for expiring cache ?
>
> Yeah .. so long as its a default and tunable in /proc.

New day, new ideea. The original problem was that unpriviledged users can
access it too often. How about exposing the MII registers as /dev entries?
Then you can have normal access rights for them and no need to worry about
frequency of access.  Probably default would be 600 owned by root and for
HA applications a user or a group can get read (or even write) access.
It's up to the sysadmin to allow it, but has to be renewed after each
boot. But I guess that this is not something to be applied to 2.2 and
2.4...

With clearer mind, I have to make some a correction to one of the previous
messages: the problem of not checking arguments range does not apply to
3c59x which has in the ioctl function '& 0x1f' for both transceiver number
and register number. However, eepro100 and tulip don't do that. (I'm
checking now with 2.4.3 from Mandrake 8, but I don't think that there were
recent changes in these areas).

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

