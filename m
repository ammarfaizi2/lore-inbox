Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbSLDPQL>; Wed, 4 Dec 2002 10:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbSLDPQL>; Wed, 4 Dec 2002 10:16:11 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:65290 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S266686AbSLDPQK>; Wed, 4 Dec 2002 10:16:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: #! incompatible -- binfmt_script.c broken?
In-Reply-To: <20021204142628.GE26745@riesen-pc.gr05.synopsys.com>
References: <20021204113419.GA20282@merlin.emma.line.org> <20021204113419.GA20282@merlin.emma.line.org> <20021204142628.GE26745@riesen-pc.gr05.synopsys.com>
Message-Id: <E18JbNE-0001OO-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Wed, 04 Dec 2002 15:23:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Riesen wrote:
>On Wed, Dec 04, 2002 at 12:34:19PM +0100, Matthias Andree wrote:
>> SuSE Linux 7.0, 7.3, 8.1 (2.4.19 kernel, binfmt_script.c identical to
>> 2.4.20 BK):
>> $ /tmp/try.pl
>> /bin/sh: -- # -*- perl -*- -T: invalid option
>
>looks correct. The interpreter (/bin/sh) has got everything after
>its name. IOW: "-- # -*- perl -*- -T"
>It's just solaris' shell (/bin/sh) just ignores options starting with
>"--". And freebsd's as well.

FreeBSD splits #! magic strings on whitespace and passes multiple
arguments. Linux passes everything after the first whitespace as a
single argument but strips trailing whitespace. NetBSD does the same as
Linux but passes trailing whitespace as part of the argument.

>Anyway - it's bash, not the bin_fmt.

Bash is (correctly) complaining that it's been passed an invalid
argument, but the reason for the different behaviour between it and
FreeBSD is because of binfmt_script. There's no clearly defined standard
for how this should behave.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
