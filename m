Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRCZWV7>; Mon, 26 Mar 2001 17:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRCZWVt>; Mon, 26 Mar 2001 17:21:49 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:16145 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129509AbRCZWVj>;
	Mon, 26 Mar 2001 17:21:39 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Hinds <dhinds@sonic.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 aic7xxx breaks pcmcia 
In-Reply-To: Your message of "Mon, 26 Mar 2001 08:48:09 PST."
             <20010326084809.A11493@sonic.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Mar 2001 08:20:53 +1000
Message-ID: <6041.985645253@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001 08:48:09 -0800, 
David Hinds <dhinds@sonic.net> wrote:
>On Mon, Mar 26, 2001 at 05:14:13PM +1000, Keith Owens wrote:
>What are the things you're planning that will cause trouble?

Support for building third party drivers and patch sets as separate
source trees.  Base kernel in in one source tree, external patch or
driver set is in another source tree, kbuild reads from multiple source
trees and writes to a separate object directory.  The multiple source
trees break the assumption that all source is in one tree, lines like
  #include <../drivers/scsi/aic7xxx.h>
do not work with multiple sources.

You are right about the long compile lines though, example with three
source trees, reflowed for readability.

/usr/bin/kgcc -I /build/kaos/2.4.1-object-kdb/arch/i386/kernel/
  -I /build/kaos/kdb/arch/i386/kernel/
  -I /build/kaos/common/arch/i386/kernel/
  -I /build/kaos/2.4.1-makefile-2.5/arch/i386/kernel/ -I-
  -D__ASSEMBLY__  -D__KERNEL__ -I include -I .tmp_include/src_002
  -I .tmp_include/src_001 -I .tmp_include/src_000 -traditional -c
  -o arch/i386/kernel/trampoline.o
  /build/kaos/2.4.1-makefile-2.5/arch/i386/kernel/trampoline.S

