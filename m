Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136579AbREAGhq>; Tue, 1 May 2001 02:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136580AbREAGhg>; Tue, 1 May 2001 02:37:36 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:39442 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S136579AbREAGh3>;
	Tue, 1 May 2001 02:37:29 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105010637.f416b51151855@saturn.cs.uml.edu>
Subject: Re: iso9660 endianness cleanup patch
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 1 May 2001 02:37:05 -0400 (EDT)
Cc: hpa@transmeta.com (H. Peter Anvin), alan@lxorguk.ukuu.org.uk (Alan Cox),
        Andries.Brouwer@cwi.nl (Andries Brouwer),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0104302312430.861-100000@penguin.transmeta.com> from "Linus Torvalds" at Apr 30, 2001 11:14:41 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Btw, please use "static inline" instead of "extern inline", as gcc may
> decide not to inline the latter at all, leading to confusing link-time
> errors. (Gcc may also decide not to inline "static inline", but then gcc
> will output the actual body of the function out-of-line if it gets used,
> so you don't get the link-time failure).
> 
> Right now only certain broken versions of gcc will actually show this
> behaviour, I think, but it's at least in theory going to be an issue.

Since the best choice depends on compiler version:

#if(GCC_VERSION_FOO)
#define __inline extern inline
#else
#define __inline static inline
#endif

(that, or _INLINE if you prefer)
