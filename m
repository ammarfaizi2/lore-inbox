Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264029AbSITX1p>; Fri, 20 Sep 2002 19:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264030AbSITX1p>; Fri, 20 Sep 2002 19:27:45 -0400
Received: from newmx2.fast.net ([209.92.1.32]:30138 "EHLO newmx2.fast.net")
	by vger.kernel.org with ESMTP id <S264029AbSITX1U>;
	Fri, 20 Sep 2002 19:27:20 -0400
Message-Id: <200209202332.TAA09371@vixen.sinz.org>
From: "Michael Sinz" <Michael.Sinz@sinz.org>
To: "Andrew Morton" <akpm@digeo.com>, "Michael Sinz" <msinz@wgate.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel List" <linux-kernel@vger.kernel.org>,
       "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>,
       "mks@sinz.org" <mks@sinz.org>,
       "riel@conectiva.com.br" <riel@conectiva.com.br>,
       "Robert Love" <rml@tech9.net>
Date: Fri, 20 Sep 2002 19:32:09 -0400
Reply-To: "Michael Sinz" <Michael.Sinz@sinz.org>
X-Mailer: sinz.org
In-Reply-To: <3D8B98D4.67A76C1C@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002 14:53:24 -0700, Andrew Morton wrote:

>Michael Sinz wrote:
>> 
>> ...
>> > Does it need to be this fancy?  Why not just have:
>> >
>> >         if (core_name_format is unset)
>> >                 use "core"
>> >         else
>> >                 use core_name_format/nodename-uid-pid-comm.core
>> >
>> > which saves all that string format processing, while giving
>> > people everything they could want?
>> 
>> Well, it depends on if you really need the complex form or not.
>> 
>> There are some people who use a format of:
>> 
>>         %N.%P.core
>> 
>> which places the core file in the current directory but adds in the
>> name of the program.  (Something that is very nice when you have
>> a lot of programs that may core "together" when something bad happens)
>
>They could use
>
>	echo . > /proc/sys/vm/core_path
> 
>> The string processing is not that much work anyway (very small)
>> and, given the fact that I am about to write to disk a core dump,
>> it can not be a critical path/fast path issue either :-)
>
>True, but it's all more code and I don't believe that it adds
>much value.  It means that people need to run off and find
>the documentation, then choose a format.  Which will be different
>from other people's chosen formats.  Which will make development
>and testing and installation of downstream scripts harder, etc.
>
>You can give people *all* the options at no cost, and without
>irritating them, and with less code.  So why make it harder for
>everyone by adding this optionality?

Yes, it could be a bit smaller by removing the format string.
You still need to do all of the string concat work abeit without
the check for what you do next.

Is that really the best way to go?  Does it really add that much to
the documentation overhead?  (Which reminds me that I should add
some documentation to the patch ;^)


-- 
Michael Sinz ---- Technology and Engineering Director/Consultant
"Starting Startups"                 mailto:michael.sinz@sinz.org
My place on the web  ------->>  http://www.sinz.org/Michael.Sinz


