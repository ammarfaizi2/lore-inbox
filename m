Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269276AbUJQTuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbUJQTuf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269272AbUJQTuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:50:35 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:5303 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S269276AbUJQTsL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:48:11 -0400
Message-ID: <4172CC6C.1010108@free.fr>
Date: Sun, 17 Oct 2004 21:47:56 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040804
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Paul Fulghum <paulkf@microgate.com>
Subject: Re: [patch, 2.6.9-rc4-mm1] fix rmmod uhci_hcd oops
References: <Pine.LNX.4.44L0.0410151318580.1052-100000@ida.rowland.org> <1097861761.2820.18.camel@deimos.microgate.com> <1097872927.5119.5.camel@krustophenia.net> <1097874840.2915.18.camel@deimos.microgate.com> <20041016160737.GA19630@elte.hu>
In-Reply-To: <20041016160737.GA19630@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9626CE6311C081DA8305D157"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9626CE6311C081DA8305D157
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Ingo Molnar wrote:
> this patch fixes the rmmod oops reported by Paul Fulghum. It is
> caused by the generic-irqs subsystem creating multiple
> /proc/irq/<nr>/<name> directory entries with the same name which
> then confuses procfs upon module removal.
> 
> Ingo

This patch fixed the problem for me.

For information, here is the the contents of my /proc/interrupts :
>            CPU0       
>   0:    1085029          XT-PIC  timer
>   1:       4473          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:     129799          XT-PIC  eth0, Ensoniq AudioPCI, uhci_hcd, uhci_hcd
>   8:          1          XT-PIC  rtc
>   9:          0          XT-PIC  acpi
>  10:          2          XT-PIC  ohci1394
>  12:      16872          XT-PIC  i8042
>  14:      12803          XT-PIC  ide0
>  15:         78          XT-PIC  ide1
> NMI:          0 
> LOC:          0 
> ERR:          0
> MIS:          0

and the contents of /proc/irq/5/ :
> /proc/irq/5/:
> total 0
> dr-xr-xr-x  2 root root 0 oct 17 21:45 Ensoniq AudioPCI/
> dr-xr-xr-x  2 root root 0 oct 17 21:45 eth0/
> dr-xr-xr-x  2 root root 0 oct 17 21:45 uhci_hcd/
> 
> /proc/irq/5/Ensoniq AudioPCI:
> total 0
> 
> /proc/irq/5/eth0:
> total 0
> 
> /proc/irq/5/uhci_hcd:
> total 0

Thank you, Paul and Ingo.

-- 
laurent


--------------enig9626CE6311C081DA8305D157
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBcsx2UqUFrirTu6IRApR8AJ4+HhNBpKKtgO4VqPTCz1zn0CdPhQCfWulB
KbLkXX921Rurn4w84TNrauw=
=vdkO
-----END PGP SIGNATURE-----

--------------enig9626CE6311C081DA8305D157--
