Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVGGKVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVGGKVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVGGKTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:19:07 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:36317 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261270AbVGGKRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:17:41 -0400
Message-ID: <42CD0141.8050407@grimmer.com>
Date: Thu, 07 Jul 2005 12:17:37 +0200
From: Lenz Grimmer <lenz@grimmer.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: [Hdaps-devel] Re: Head parking (was: IBM HDAPS things are looking
 up)
References: <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de> <42CCEAA7.1010807@grimmer.com> <20050707084825.GG1823@suse.de>
In-Reply-To: <20050707084825.GG1823@suse.de>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=B27291F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Jens Axboe wrote:

> Very cool, I wasn't sure if this was a 'new' feature waiting to be 
> implemented in drives or if ata7 just documented existing use in some
>  drives.
> 
> How long did the park take? Spec states it can take up to 500ms.

Hard to measure (I don't have the C skills to add timing to your sample
snippet...), but almost instantly after issuing the command. "time"
states the command takes around 0.733 seconds in total (until the
command returns), the head park happens almost instantly after the
program started, probably after ~300ms).

> The head just remains parked until the next command is issued.

Right, which usually happens right away on a busy system, especially
when it's using swap (think KDE desktops :) )

> This needs to be combined with some ide help, to freeze the queue.
> Perhaps some sysfs file so you could do
> 
> # echo park > /sys/block/hda/device/head_state
> 
> Or whatever, at least just exposing this possibility so that the
> drive internally can block future io until a 'resume' command is
> issued.

Or for a given timeout, whatever happens first. Sounds good to me!
So would this feature require modifications to the IDE layer?

Bye,
	LenZ
- --
- ------------------------------------------------------------------
 Lenz Grimmer <lenz@grimmer.com>                             -o)
 [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
 http://www.lenzg.org/                                       V_V
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCzQE+SVDhKrJykfIRAtN9AJ9207U5cJIw1i5a0t+PsrkbbkW6/ACfZk0M
D0l/YVWoiq+Jo0zw+mqFV9g=
=Eda0
-----END PGP SIGNATURE-----
