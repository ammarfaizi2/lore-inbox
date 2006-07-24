Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWGXPe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWGXPe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 11:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWGXPe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 11:34:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:57636 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750933AbWGXPe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 11:34:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V2d+sxGsZoEa9KAa9kwim1BjX/Ln7nZtfPxMOZ6h+H2Hmd0Qns/R9/oJspSePDG2LIXJpSyChvFJN9UmGMXfJN8ki4iHjBhVwHmQ7ttM8t31cx013XaYwXAwLtOlsQ7P9kwkIVO9zWWcY3Gy3u0OqiV2qUbzCFT93brdGRR/16c=
Message-ID: <f96157c40607240834i5ba3ca5cma51eec9fa34558bc@mail.gmail.com>
Date: Mon, 24 Jul 2006 15:34:25 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Roman Zippel" <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: Re: i686 hang on boot in userspace
In-Reply-To: <f96157c40607190326t1071377bvb426e00d6f427660@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060714150418.120680@gmx.net>
	 <Pine.LNX.4.64.0607171605500.6761@scrub.home>
	 <f96157c40607170759p1ab37abdi88d178c3503fb2e1@mail.gmail.com>
	 <Pine.LNX.4.64.0607171718140.6762@scrub.home>
	 <f96157c40607170858o567abe24r5d9bdd4895a906c9@mail.gmail.com>
	 <f96157c40607170902l47849e42qc4f1c64087a236d8@mail.gmail.com>
	 <Pine.LNX.4.64.0607171902310.6762@scrub.home>
	 <f96157c40607171115r4acccb00r3f6d93e3477a3a13@mail.gmail.com>
	 <f96157c40607180238s1bfe0ca2te1d4d72dbe8626fd@mail.gmail.com>
	 <f96157c40607190326t1071377bvb426e00d6f427660@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the problem I have with hangs is related to changes in CFQ and that
CFQ is now the default. 2.6.17-git12 had the problem but booting
it with elevator=deadline fixes the hang.

symptoms encountered during git-bisecting between v2.6.17 and v2.6.18-rc1:
 A hang while starting network services
 B hang while trying to login
   1 on remote console [not SSH] it hang after typing <uid><CR>
   1 via OpenSSH it hang after typing <pwd><CR> when doing slogin root@<IP>

A is the problem I got in the first place and this seems to be the
case since 2.6.17-git11 definitely although git-bisect pointed me at
the following
changeset which is included since 2.6.17-git12:

caaa5f9f0a75d1dc5e812e69afdbb8720e077fd3
by Jens Axboe
titled "[PATCH] cfq-iosched: many performance fixes"

strange enough it also hangs with 2.6.17-git11 which did not include that
one changeset yet.

to sum it up "elevator=deadline" fixes the problem, so CFQ seems to be
buggy in the current Torvalds 2.6 tree.

therefore, sorry Roman for bugging you, Jens seems to be the right person to
ping about the problem.
