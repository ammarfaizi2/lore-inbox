Return-Path: <linux-kernel-owner+w=401wt.eu-S932731AbWL0LyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbWL0LyO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 06:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWL0LyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 06:54:14 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37401 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932731AbWL0LyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 06:54:12 -0500
Date: Wed, 27 Dec 2006 12:46:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
cc: Theodore Tso <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
       Arnd Bergmann <arnd@arndb.de>, Karel Zak <kzak@redhat.com>,
       linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>
Subject: Re: util-linux: orphan
In-Reply-To: <5a4c581d0612270324k20725779j86e9ee9b364e5b2b@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0612271243270.14578@yvahk01.tjqt.qr>
References: <20061109224157.GH4324@petra.dvoda.cz>  <20061218071737.GA5217@petra.dvoda.cz>
  <200612270346.10699.arnd@arndb.de> <4591E3BB.9070806@zytor.com> 
 <20061227043501.GA7821@thunk.org> <5a4c581d0612270324k20725779j86e9ee9b364e5b2b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 27 2006 12:24, Alessandro Suardi wrote:
> On 12/27/06, Theodore Tso <tytso@mit.edu> wrote:
>> On Tue, Dec 26, 2006 at 07:08:43PM -0800, H. Peter Anvin wrote:

>>>> I saw that the current Fedora already dynamically links
>>>> /bin/mount against /usr/lib/libblkid.so. This obviously does not
>>>> work if /usr is a separate partition that needs to be mounted
>>>> /with bin/mount. I also had problems with selinux claiming I had
>>>> no right to access libblkid, which meant that the root fs could
>>>> not be remounted r/w.
>>>> 
>>>> I'd suggest that you make sure that mount always gets statically
>>>> linked against libblkid to avoid these problems.
>>> 
>>> That's a pretty silly statement.  The real issue is that any
>>> library needed by binaries in /bin or /sbin should live in /lib,
>>> not /usr/lib.
>> 
>> From a Debian unstable system:
>> 
>> think:~# ldd /bin/mount
>> libblkid.so.1 => /lib/libblkid.so.1 (0xb7f23000)
>
> FC6-current for i386 has it right:
>
> [root@sandman ~]# ldd /bin/mount
> libblkid.so.1 => /lib/libblkid.so.1 (0x4b607000)

And so does openSUSE 10.2:

ichi$ ldd /bin/mount
        libblkid.so.1 => /lib/libblkid.so.1 (0xa7f4f000)

Interestingly enough, SUSE Linux 10.1 i586/x86_64 had it statically
ccg$ ldd /bin/mount
        libc.so.6 => /lib64/libc.so.6 (0x00002b489072e000)
        /lib64/ld-linux-x86-64.so.2 (0x0000555555554000)
        (that's all folks)

Now what puzzles is that FC6's mapping address is quite 'off' - the
host "think" has it near PAGE_OFFSET (0xc0000000), as does "ichi"
(PAGE_OFFSET=0xb0000000), so what's with "sandman"?

	-`J'
-- 
