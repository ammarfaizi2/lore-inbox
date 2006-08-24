Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWHXR1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWHXR1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWHXR1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:27:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:50835 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030414AbWHXR1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:27:13 -0400
Subject: Re: [PATCH 2/4] Core support for --combine -fwhole-program
From: Josh Triplett <josht@us.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1156433167.3012.119.camel@pmac.infradead.org>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433167.3012.119.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 10:27:18 -0700
Message-Id: <1156440438.3418.25.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 16:26 +0100, David Woodhouse wrote:
> This patch adds a config option for COMBINE_COMPILE, adds the __global
> tag to compiler.h and makes EXPORT_SYMBOL automatically use it. It also
> contains a crappy Makefile hack which uses -fwhole-program --combine for
> all multi-obj .o files -- anything which was 
> 	obj-m := foo.o
> 	foo-objs := bar.o wibble.o 
> ... should now use gcc -o foo.o --combine -fwhole-program bar.c wibble.c
> 
> The makefile hack is known not to work properly for generated C files in
> out-of-source-tree builds, and for multi-obj files where one of the
> sources is _assembly_ instead of C. It's good enough for the proof of
> concept, until someone more clueful can do it properly though. It would
> be useful to make built-in.o build with --combine from _everything_
> which uses standard CFLAGS, rather than doing just what I've done here.

Would the generation and use of preprocessed source files ($x.c -> $x.i)
help solve the "standard CFLAGS" problem here, and allow a subsequent
single compilation of the entire kernel (sans modules) with --combine
-fwhole-program?

- Josh Triplett


