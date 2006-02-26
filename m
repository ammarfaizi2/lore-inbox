Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWBZQVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWBZQVG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 11:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWBZQVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 11:21:06 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:48105 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751334AbWBZQVF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 11:21:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=e6qKddCe5gPc7NQmofrU8nXeXhCH78Q7FrX/ayyxaks5FVIv2YeQ5FLdPgATUkuvhGRyT844OeHmZg2/TvK17tC47K11yABGYrbnhlyMPE/ikYqFf2ppqWy6U9/84XmTAWgBjeLMqLGDy/BnQ9iKgweB2XsHvqc8DzHbNyPBaps=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Building 100 kernels; we suck at dependencies and drown in warnings
Date: Sun, 26 Feb 2006 17:21:17 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602261721.17373.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)

	95 kernels were build with 'make randconfig'.
	1 kernel was build with the config I normally use for my own box.
	1 kernel was build from 'make defconfig'.
	1 kernel was build from 'make allmodconfig'.
	1 kernel was build from 'make allnoconfig'.
	1 kernel was build from 'make allyesconfig'.

That was an interresting experience. 

First of all not very many of the kernels actually build correctly and 
secondly, if I grep the build logs for warnings I'm swamped.

Out of 100 kernels 82 failed to build - that's an 18% success rate people, 
not very impressive.

Some of the failed builds are due to things like CONFIG_STANDALONE that 
will break the build if not set to Y (unless you have the firmware 
available ofcourse), but looking at the config files I find that only 26 
kernels have CONFIG_STANDALONE unset, so that only accounts for a quarter
of the kernels.

A lot of failed builds are due to invalid combinations of some stuff 
being build-in and some stuff being build as modules.
This, as far as I'm concerned, is something that the dependencies in 
Kconfig should make impossible - hence my conclusion that we suck at deps.

>From 100 kernel builds there was a total of 16152 warnings and 645 of those
are unique warnings, the rest are duplicates.

We are drowning in warnings people. Sure, many of the warnings are due to 
gcc getting something wrong and shouldn't really be emitted, but a lot of 
them point to actual problems or deficiencies (I obviously haven't looked 
at them all in detail yet, so take that with a grain of salt please).

In any case, it looks to me like we have some serious clean-up work to do.

Unfortunately I don't have anywhere to put all the configs and logs online,
but I can send them on request, or if someone can point at a space to 
upload them to I'll gladly make them available.

That's it for now, I'll get to work trying to clean up some of the breakage
I've seen, if anyone wants to join in feel free :)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html


