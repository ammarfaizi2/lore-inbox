Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263592AbSITVpg>; Fri, 20 Sep 2002 17:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263599AbSITVpg>; Fri, 20 Sep 2002 17:45:36 -0400
Received: from packet.digeo.com ([12.110.80.53]:21190 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263592AbSITVpe>;
	Fri, 20 Sep 2002 17:45:34 -0400
Message-ID: <3D8B982A.2ABAA64C@digeo.com>
Date: Fri, 20 Sep 2002 14:50:34 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Sinz <msinz@wgate.com>
CC: mks@sinz.org, marcelo@conectiva.com.br, Robert Love <rml@tech9.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, riel@conectiva.com.br,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
References: <3D8B87C7.7040106@wgate.com> <3D8B8CAB.103C6CB8@digeo.com> <3D8B934A.1060900@wgate.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 21:50:34.0476 (UTC) FILETIME=[BF6BD2C0:01C260EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Sinz wrote:
> 
> ...
> > Does it need to be this fancy?  Why not just have:
> >
> >         if (core_name_format is unset)
> >                 use "core"
> >         else
> >                 use core_name_format/nodename-uid-pid-comm.core
> >
> > which saves all that string format processing, while giving
> > people everything they could want?
> 
> Well, it depends on if you really need the complex form or not.
> 
> There are some people who use a format of:
> 
>         %N.%P.core
> 
> which places the core file in the current directory but adds in the
> name of the program.  (Something that is very nice when you have
> a lot of programs that may core "together" when something bad happens)

They could use

	echo . > /proc/sys/vm/core_path

 
> The string processing is not that much work anyway (very small)
> and, given the fact that I am about to write to disk a core dump,
> it can not be a critical path/fast path issue either :-)

True, but it's all more code and I don't believe that it adds
much value.  It means that people need to run off and find
the documentation, then choose a format.  Which will be different
from other people's chosen formats.  Which will make development
and testing and installation of downstream scripts harder, etc.

You can give people *all* the options at no cost, and without
irritating them, and with less code.  So why make it harder for
everyone by adding this optionality?
