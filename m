Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267968AbUHUWNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267968AbUHUWNH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 18:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267965AbUHUWNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 18:13:07 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:8668 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S267978AbUHUWMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 18:12:47 -0400
Message-ID: <4127C8D1.8040601@g-house.de>
Date: Sun, 22 Aug 2004 00:12:33 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Christian Hesse <mail@earthworm.de>
Subject: Re: v2.6.8.1 breaks tspc
References: <200408212303.05143.mail@earthworm.de>
In-Reply-To: <200408212303.05143.mail@earthworm.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christian Hesse wrote:
> Hello!
>
> Kernel version 2.6.8.1 breaks tspc (Freenet6's Tunnel Server Protocol
Client).
> It tries to connect to the server but waits forever. No problems with
2.6.7,
> booted the old kernel and it worked perfectly.

aha, and i thought freenet6's tunnel server has problems again.
reproduceable here with 2.6.8(.1), 2.6.7 was working indeed.
ipv6 module is loaded, the tspc client does not give much information of
what it is doing. maybe strace help here:

socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
connect(4, {sa_family=AF_INET, sin_port=htons(53),
sin_addr=inet_addr("127.0.0.1")}, 28) = 0
send(4, "\363\t\1\0\0\1\0\0\0\0\0\0\5tsps2\10freenet6\3net\0"..., 36, 0)
= 36
gettimeofday({1093126256, 233665}, NULL) = 0
poll([{fd=4, events=POLLIN, revents=POLLIN}], 1, 5000) = 1
ioctl(4, FIONREAD, [128])               = 0
recvfrom(4,
"\363\t\201\200\0\1\0\1\0\1\0\2\5tsps2\10freenet6\3net\0"..., 1024, 0,
{sa_family=AF_INET, sin_port=htons(53),
sin_addr=inet_addr("127.0.0.1")}, [16]) = 128
close(4)                                = 0
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 4
connect(4, {sa_family=AF_INET, sin_port=htons(3653),
sin_addr=inet_addr("206.123.31.115")}, 16) = 0
write(4, "VERSION=1.0.1\r\n", 15)       = 15
read(4,
[...and then read() waits until the of the world as we know it]


Christian,
(searching for a free tunnel-broker in .de anyway...)

- --
BOFH excuse #370:

Virus due to computers having unsafe sex.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBJ8jR+A7rjkF8z0wRAnjGAKCFIjdsR2TZxxhcv/ukV+xzubWWwACgm85p
kcJ3QFgTASSrQGM6pnpbW5I=
=nqGW
-----END PGP SIGNATURE-----
