Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264107AbUD0O1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbUD0O1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 10:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUD0O1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 10:27:05 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:39085 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264107AbUD0O0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 10:26:48 -0400
Date: Tue, 27 Apr 2004 16:26:43 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Anyone got aic7xxx working with 2.4.26?
Message-ID: <20040427142643.GA10553@merlin.emma.line.org>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <200404261532.37860.dj@david-web.co.uk> <20040426161004.GE5430@merlin.emma.line.org> <20040427131941.GC10264@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427131941.GC10264@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Marcelo Tosatti wrote:

> What is the compile error with 2.4-BK-current? 

Well, it used to be one that went away after I typed:

cp .config /tmp
make distclean
bk -Ur get -S         # <- this checked out dozens of include files
mv /tmp/.config .
make oldconfig dep
make bzImage modules

The problem was:

(1) glibc-devel (SuSE Linux) installs includes into /usr/include/linux.
    These are older includes (UTS_RELEASE 2.4.20, LINUX_VERSION_CODE
    132116).

(2) BK had removed some of the include files in the course of a "bk pull"

(3) "make dep" and the kernel stuff picked up the stale includes from
    /usr/include/linux instead of /space/BK/linux-2.4/include/...

    Apparently, the (relative) include/ directory has precedence, but
    the kernel build system falls back to looking in /usr/include/linux.

I don't know the kernel build system well enough to make a qualified
comment why this happened, might have been missing dependencies, missing
paths relative to the kernel source directory or something, or might be
the use of VPATH where it shouldn't be used or with too broad paths.

sym53c8xx_2 is also fine currently, I'm using it for my system disk as I
am writing this. This problem started earlier than compile errors
(incompatibly redefined symbols and such), so it may have had some stale
include files already but not enough to jam the build.

> Did you post the boot messages with sym53c8xx_2? Can you use sym53c8xx?

No, I didn't because I wasn't confident it was my own fault.

I haven't used ncr53c8xx or sym53c8xx in ages and don't intend to.

So everything is fine for me - except that this may happen to everyone
again at any time unless the build system is fixed to that make can
"get" (as in bk get) the include files.

Someone posted patches to fix this some weeks ago, but the patches
apparently fell on the floor unheeded, I don't recall if this was for
2.4 or 2.6.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
