Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261636AbTCGPvq>; Fri, 7 Mar 2003 10:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbTCGPvq>; Fri, 7 Mar 2003 10:51:46 -0500
Received: from 237.oncolt.com ([213.86.99.237]:4830 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261636AbTCGPvp>; Fri, 7 Mar 2003 10:51:45 -0500
Subject: Re: 2.5.51 CRC32 undefined
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Arun Prasad <arun@netlab.hcltech.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303070749160.2876-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303070749160.2876-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047052741.32200.82.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 07 Mar 2003 15:59:01 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 15:49, Linus Torvalds wrote:
> I don't want to have configs like this. I personally refuse to load 
> modules into my kernel, and as such a subsystem that only works as a 
> module is _evil_.

It works built-in and would continue to do so with this patch applied.

It's built into your kernel _automatically_ if anything built-in
requires it. That's done by the makefiles. Likewise, it's built as a
module automatically if anything modular in your tree requires it.

The config option is _only_ relevant if you are explicitly adding crc32
in the knowledge that you're going to build an _external_ module which
requires it.  

However, setting the config option to 'Y' when you have only _modular_
stuff which requires it is broken because it doesn't actually get pulled
in from lib/lib.a, because nothing references it.

-- 
dwmw2

