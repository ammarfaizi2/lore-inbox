Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWCZRFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWCZRFj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWCZRFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:05:39 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:65168 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932094AbWCZRFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:05:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=QbrRJCjU799TyF7W6g3xTgIFXl2SldXIf02lN9EBkEfboVsbRHV/it4NaOX2dSqnvg7mpe0Smsd8BW0O64oWUHAjYBw0Bz1WI01yI19bwhO+uHH4yi2QqAyPN3qBIrWf2KMX7X/aVSl8lA/wtkTMXwCVluoqR3eanxAgyQhdokA=
Message-ID: <4426CADF.2050902@gmail.com>
Date: Mon, 27 Mar 2006 00:09:51 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Glynn Clements <glynn@gclements.plus.com>
CC: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Re: Virtual Serial Port
References: <442582B8.8040403@gmail.com> <Pine.LNX.4.61.0603251945100.29793@yvahk01.tjqt.qr> <4425FB22.7040405@gmail.com> <Pine.LNX.4.61.0603261127580.22145@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603261127580.22145@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>   guest writes to /dev/ttyS0
>   vmware connects its virtual S0 to the host's ttyFakeS0
>   minicom on the host to ttyFakeS0
> or even
>   vmware S0 to host's ttyS0
>   other remote machine do minicom to ttyS0
> 
> The reason for FakeS0 is that vmware does not know about ptys, 
> unfortunately.

Yes, VMWare doesn't support serial port using host's ttys any more. My
idea is:

[host - application] <- read/write -> [virtual serial port
/dev/ttyFakeS0] <- read/write over virtual null-modem serial cable ->
[host - real serial port /dev/ttyS0] <- read/write -> [VMWare - application]

But today I've just bought an USB-to-Serial converter and made for
myself a null-modem serial cable. I use this null-modem cable to connect
/dev/ttyS0 (native serial port) to /dev/tts/USB0 (USB-based serial
port). My VMWare now can use one of those devices and the host use
another one. Now above figure can be re-drawn like this:

[host - application] <- read/write -> [/dev/tts/USB0] <- read/write over
physical null-modem cable -> [/dev/ttyS0] <- read/write -> [VMWare -
application]

Anyway, later I'll try to write a device drivers act as virtual serial
ports and virtual null-modem cables.

Best regards,
Mikado.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJsrfNWc9T2Wr2JcRAl05AJ9Ee8zqagf0yjDk71mFAxwSskFltQCg0aM8
mELZ8uxHPaSYzLiZLM7Cxy4=
=zI/+
-----END PGP SIGNATURE-----
