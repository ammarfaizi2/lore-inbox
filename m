Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVF2N2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVF2N2C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 09:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVF2N2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 09:28:02 -0400
Received: from mail.tnnet.fi ([217.112.240.26]:63653 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S262569AbVF2N16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 09:27:58 -0400
Message-ID: <42C2A1D5.D586E874@users.sourceforge.net>
Date: Wed, 29 Jun 2005 16:27:49 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: accessing loopback filesystem+partitions on a file
References: <20050628233335.GB9087@lkcl.net> <Pine.LNX.4.63.0506290228380.7125@alpha.polcom.net> <20050629015030.GG9566@lkcl.net>
Content-Type: multipart/mixed;
 boundary="------------BA9C1B5A3D98E3110D115655"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BA9C1B5A3D98E3110D115655
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Luke Kenneth Casson Leighton wrote:
> such that it is possible to then subsequently do this:
> 
> fdisk /dev/loopblocka and
> mkfs.ext2 /dev/loopblocka1
> mount /dev/loopblocka1 -t ext2 /mnt/somewhere

Using attached image-mount script that is possible. Like this:

  ln -s image-mount image-losetup
  fdisk filename
       (remember to set correct cyl/head/sect before creating partitions)
  ./image-losetup /dev/loop7 filename 2
  mkfs.ext2 /dev/loop7
  mount /dev/loop7 -t ext2 /mnt/somewhere
  umount /mnt/somewhere
  losetup -d /dev/loop7

or

  ./image-mount filename 2 /mnt/somewhere
  umount /mnt/somewhere

Good news is that image-mount and image-losetup scripts get both size and
offset of the partition right, so mkfs creates correct size file system. Bad
news is that it only works with losetup and mount programs from loop-AES
package. Google for "loop-AES" if you can't find it.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
--------------BA9C1B5A3D98E3110D115655
Content-Type: application/octet-stream;
 name="image-mount.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="image-mount.bz2"

QlpoOTFBWSZTWfEzhWEAAI5fgEAQfJf/OsyVWop/7//+QAIbaxu4Aamp6kA2UxNBoNA0DQaA
0B6jR6glEaTCJtJiampvVP1TTRoAGgyaPUA0GISp5T0ZIZAeoHqBo0aG1NAYjR6glSnqeoME
BpgQDQGhoGmmgAGJMpZwhV9eMDbd0LMWbZwq2ia4UMsG5lEyCCG0QSMiJhCiN9U91paOc72d
zM6HJUZSfKcO4Y7HXU+2xc/l2OR4Fg0G6VQEq4ETAbEwQR4+k4biBeALatseR1gFpuIz4Fkq
0aW+HPf55FvefESk92rBi/xLxNRRc3bdeexwyTGDlcM+8hYSiR23rQ8IGdWSOYSh0kZBD8iH
FaCRMX/N9c0700DnEoEgUM43QxklDDYZq6anINOu/WE3QOLlDdlyZrqr2FA6tAY8GpiRjFoq
SE4OAQQS+Fhp9H2qPRCk1KYZQWV14kAGTlOE1CWZIYif4iRaBv5gUQMBSWIhvg/YQJaHwiSK
SyEFymI5B+QJURwqg4RXIFZBVKBgI6jTDTfAvtElZgdRzQRY12F3ngzOdfD+unjYMQIg/gOt
aEsJEgZcQlo86IwID1VImaBI6OYkayEfNj/K8OALdcqpZUsDRR6X7miNqZDeip3xgEjA3l9T
bcHTLATrno92JQezyYlqWGlw9H8a60XMcJdYmRFJQjAkDgxVsQoHytPH5ScczJ5klg8weOuv
UfsesEKIHUabC645eQbRzo2VmSj/xdyRThQkPEzhWEA=
--------------BA9C1B5A3D98E3110D115655--

