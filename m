Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292589AbSBZBJX>; Mon, 25 Feb 2002 20:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292590AbSBZBJO>; Mon, 25 Feb 2002 20:09:14 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:10508 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S292589AbSBZBJI>; Mon, 25 Feb 2002 20:09:08 -0500
Message-Id: <4.3.2.7.2.20020225200130.00cea7f0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 25 Feb 2002 20:09:09 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: Re: Linux 2.4.18
In-Reply-To: <3C7AB893.4090800@ellinger.de>
In-Reply-To: <20020225200618.0FAE82069E@eos.telenet-ops.be>
 <Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva>
 <20020225.140851.31656207.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:20 PM 2/25/02, you wrote:
>David S. Miller wrote:
>
>>We can avoid this kind of mess in the future if the "-rc*" releases
>>really are "release candidates" instead of "just another diff".
>
>And how should EXTRAVERSION be accommodated?

An idea :-)

The actual release could be automated by a script that copies the release 
candidate directory to a final directory, uses sed to correct EXTRAVERSION, 
then creates the tarball.  Using a script would ensure that EXTRAVERSION is 
correctly handled and would create all necessary tarballs and signature files.

The "Kernel_Release" script would look something like:

         mkdir /usr/src/linux-$1
         ( cd /usr/src/linux-$1-rc$2 ; tar cf - ) | ( cd /usr/src/linux-$1 
; tar xf - )
         sed s/EXTRAVERSION=.*/EXTRAVERSION/ < 
/usr/src/linux-$1-rc$2/Makefile > /usr/src/linux-$1/Makefile
         tar zcf linux-$1.tar.gz linux-$1
         tar jcf linux-$1.tar.bz2 linux-$1
         cp linux-$1.tar.gz linux-$1 jcf linux-$1.tar.bz2 linux-$1 
ftp/pub/linux/kernel/v2.4
         ... whatever other magic is neded ...





