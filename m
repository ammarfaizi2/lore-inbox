Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316285AbSEKXjJ>; Sat, 11 May 2002 19:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316286AbSEKXjI>; Sat, 11 May 2002 19:39:08 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:55510 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S316285AbSEKXjH>; Sat, 11 May 2002 19:39:07 -0400
Message-Id: <5.1.0.14.2.20020512092751.02bcca40@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 12 May 2002 09:38:12 +1000
To: Linus Torvalds <torvalds@transmeta.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH]
  2.5.14 IDE 56)
Cc: Larry McVoy <lm@bitmover.com>, Gerrit Huizenga <gh@us.ibm.com>,
        Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205111130080.879-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as the person who started this whole thread and made the assertion that 
copying from A to B is common:

At 11:35 AM 11/05/2002 -0700, Linus Torvalds wrote:
>And I personally believe that "generate the data yourself" is actually a
>very common case. A pure pipe between two places is not what a computer is
>good at, or what a computer should be used for.

i think you'd be surprised.  if we include "pipe from disk to network" then 
a large number of 'server' applications do exactly this.
webservers do.  fileservers do. http caches do.  streaming-media servers do.

sure, they may add additional headers on the front and still generate 
dynamic content in some cases, but the "common case" is 'pipe from disk to 
network' or 'pipe from network to disk'.
'network' is typically TCP but can be UDP (with rate-limiting) in some cases.


its very good to see this being discussed.  thats a large step forward from 
many people believing the problem was nonexistent.

i'm skeptical that continuing to use the page-cache is the correct way to 
go -- many of these kinds of applications are doing their own form of 
memory-management and hot-content 'caching' so are happy to manage a 
few-to-several hundred megabytes of "page cache equivalent" data themselves.
at least on many of the 2.3.xx linux releases, that was one of the big 
attractions of 'raw' devices -- they didn't get the box into an OOM situation.
if 2.5.xx and recent 2.4.xx has the issues of 
page-cache-doesn't-shrink-fast-enough solved, then its forseeable it will fly.


cheers,

lincoln.

