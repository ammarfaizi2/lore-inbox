Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVCYSBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVCYSBc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVCYSBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:01:32 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:20381 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261706AbVCYSBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:01:25 -0500
Message-ID: <424451F2.5070201@free.fr>
Date: Fri, 25 Mar 2005 19:01:22 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20041217
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl, rlrevell@joe-job.com,
       alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.12-rc1-mm2
References: <20050324044114.5aa5b166.akpm@osdl.org> <1111682812.23440.6.camel@mindpipe> <20050324121722.759610f4.akpm@osdl.org> <200503242331.46985.rjw@sisk.pl> <42434E59.2060805@free.fr> <20050324154920.4e506d76.akpm@osdl.org> <Pine.LNX.4.50.0503241658360.29178-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0503241658360.29178-100000@monsoon.he.net>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6FA4E2C925427CC22E33E638"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6FA4E2C925427CC22E33E638
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


Le 25.03.2005 02:00, Patrick Mochel a écrit :
> On Thu, 24 Mar 2005, Andrew Morton wrote:
>
>
>>Laurent Riffard <laurent.riffard@free.fr> wrote:
>>
>>> hello,
>>>
>>> Same kinds of problem here. It depends on the removed module. I
>>> mean: "rmmod loop" or "rmmod pcspkr" works. But "rmmod
>>> snd_ens1371" or "rmmod ohci1394" hangs.
>>>
>>> Sysrq-T when rmmoding snd_ens1371 :
>
> <snip>
>
>> It looks like we're getting stuck in the wait_for_completion() in
>> the new klist_remove().
>
> D'oh! It's getting hung while waiting to remove the current node from
> the list (which it can't remove because it's being used). The patch
> below should fix it.
>
> 	Pat
>
>
> ===== drivers/base/dd.c 1.3 vs edited =====
> --- 1.3/drivers/base/dd.c	2005-03-21 12:25:04 -08:00
> +++ edited/drivers/base/dd.c	2005-03-24 16:55:21 -08:00
> @@ -177,7 +177,7 @@
>
>  	sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
>  	sysfs_remove_link(&dev->kobj, "driver");
> -	klist_remove(&dev->knode_driver);
> +	klist_del(&dev->knode_driver);
>
>  	down(&dev->sem);
>  	device_detach_shutdown(dev);

Ok, I can confirm this patch solved the problem.

Thanks for your help.
--
laurent

--------------enig6FA4E2C925427CC22E33E638
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCRFHyUqUFrirTu6IRAj9jAJ4kXF7GFwoHc6LAPIw2DLlAarASzwCgurb8
9H0ddYoQs8cdA7MmRZbEoCU=
=5NOf
-----END PGP SIGNATURE-----

--------------enig6FA4E2C925427CC22E33E638--
