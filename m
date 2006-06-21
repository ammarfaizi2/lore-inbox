Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWFUQXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWFUQXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWFUQXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:23:49 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:19935 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932228AbWFUQXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:23:49 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Wouter Paesen <wouter@kangaroot.net>
Subject: Re: [RFC][PATCH 2.6.17-rc6] input/mouse/sermouse: fix memleak and potential buffer overflow
Date: Wed, 21 Jun 2006 18:23:37 +0200
User-Agent: KMail/1.9.3
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
References: <20060615104702.GA4866@tougher.kangaroot.net> <200606180024.32759.dtor_core@ameritech.net> <20060620064127.GA25367@tougher.kangaroot.net>
In-Reply-To: <20060620064127.GA25367@tougher.kangaroot.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8117541.hsLRlRA5Ra";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606211823.43160@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8117541.hsLRlRA5Ra
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Wouter Paesen wrote:
>On Sun, Jun 18, 2006 at 12:24:31AM -0400, Dmitry Torokhov wrote:
>> >   Because serio->phys is also a 32 character field the sprintf could
>> >   result in 39 characters being written to the sermouse->phys.
>>
>> Right, we need to change it to use snprintf.
>
>Thanks, this patch will do just that.
>Still, keeping the array 39 characters long will prevent truncation of the
> string.
>
>Signed-off-by: Wouter Paesen <wouter@kangaroot.net>
>
>--- linux-2.6.17-rc6.orig/drivers/input/mouse/sermouse.c 2006-06-20
> 08:31:12.000000000 +0200 +++
> linux-2.6.17-rc6/drivers/input/mouse/sermouse.c 2006-06-20
> 08:31:41.000000000 +0200 @@ -53,7 +53,7 @@ struct sermouse {
> 	unsigned char count;
> 	unsigned char type;
> 	unsigned long last;
>-	char phys[32];
>+	char phys[39];
> };
>
> /*
>@@ -254,7 +254,7 @@ static int sermouse_connect(struct serio
> 		goto fail;
>
> 	sermouse->dev = input_dev;
>-	sprintf(sermouse->phys, "%s/input0", serio->phys);
>+	snprintf(sermouse->phys, 39, "%s/input0", serio->phys);

This adds a magic number here. I suggest using sizeof(sermouse->phys) instead.

Eike

--nextPart8117541.hsLRlRA5Ra
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBEmXKPXKSJPmm5/E4RAk2NAJwKUj31rWjtcAt4il7m26x8wr/TuACfe6X7
mGrjf3fzYg9cVVabUpLWlWc=
=8x2F
-----END PGP SIGNATURE-----

--nextPart8117541.hsLRlRA5Ra--
