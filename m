Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315711AbSEILdt>; Thu, 9 May 2002 07:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSEILds>; Thu, 9 May 2002 07:33:48 -0400
Received: from stingr.net ([212.193.32.15]:3713 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S315711AbSEILdr>;
	Thu, 9 May 2002 07:33:47 -0400
Date: Thu, 9 May 2002 15:33:46 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Some useless cleanup
Message-ID: <20020509113346.GB1125@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020509102841.GA1125@stingr.net> <200205091102.g49B2AX25891@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Denis Vlasenko:
> Well, it isn't bad, but what's the point in multiple
> set_xxxxxx(char *dst, char *src) functions?
> 
> Maybe it makes more sense to have a generic macro
> which copies string into char[N] buffer, avoiding overflow.
> 

Generic plan. I has something in mind when asked, but not this ...

Actually in task_t.comm we have 2 cases
1. strncpy(a, b, sz)
2. snprintf(a, n, blah-blah...)

I thought somebody will beat me for completely eliminating strcpyn and
replacing it with snprintf in ALL CASES which is more expensive.

> A macro:
> 
> #define STRNCPY(dst,src) \
> 	do { \
> 		/* todo: put clever check that dst is char[] here */ \
> 		strncpy((dst), (src), sizeof(dst)-1); \
> 		dst[sizeof(dst)-1] = '\0'; \
> 	} while(0)

Abstracting .comm access can result in, finally, replacing comm[16] with,
for example, *comm

Or if we require to do match_comm (netfilter match, connections belong to
process specified by name) job we can patchhook somewhere in set_xxx to
avoid excessive for_each_tasked strcmps.

... more?

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
