Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbTIKINY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 04:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbTIKINY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 04:13:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5024 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261155AbTIKINX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 04:13:23 -0400
Date: Tue, 9 Sep 2003 22:56:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: insecure <insecure@mail.od.ua>
Cc: Michael Frank <mhf@linuxmail.org>, Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: nasm over gas?
Message-ID: <20030909205626.GJ3944@openzaurus.ucw.cz>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309050128.47002.insecure@mail.od.ua> <200309052058.11982.mhf@linuxmail.org> <200309052028.37367.insecure@mail.od.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309052028.37367.insecure@mail.od.ua>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A random example form one small unrelated program (gcc 3.2):
> 
> main:
>         pushl   %ebp
>         pushl   %edi
>         pushl   %esi
>         pushl   %ebx
>         subl    _32, %esp
>         xorl    %ebp, %ebp
>         cmpl    _1, 52(%esp)
>         movl    _0, 20(%esp)
>         movl    _1000000, %edi      <----
>         movl    _1000000, 16(%esp)  <----
>         movl    _0, 12(%esp)
>         movl    _.LC27, 8(%esp)
>         je      .L274
>         movl    _1, %esi
>         cmpl    52(%esp), %esi
>         jge     .L272
> 
> No sane human will do that.
> 
> main:
>         pushl   %ebp
>         pushl   %edi
>         pushl   %esi
>         pushl   %ebx
>         subl    _32, %esp
>         xorl    %ebp, %ebp
>         cmpl    _1, 52(%esp)
>         movl    _0, 20(%esp)
>         movl    _1000000, %edi
>         movl    %edi, 16(%esp)	<-- save 4 bytes
>         movl    %ebp, 12(%esp)  <-- save 4 bytes
>         movl    _.LC27, 8(%esp)

Hmm, but gcc version is likely faster. No sane person would write
multiply by 5 using single lea instruction, yet gcc will do that...
				Pavel 
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

