Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUAEVMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbUAEVMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:12:35 -0500
Received: from mout2.freenet.de ([194.97.50.155]:8638 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S265366AbUAEVLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:11:49 -0500
Date: Mon, 5 Jan 2004 21:53:16 +0100
From: j.beyer@web.de
To: linux-kernel@vger.kernel.org
Subject: build requirements for 2.6.0 (make)
Message-ID: <20040105205315.GA27080@dilbert.beyer.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Listreader,

the Documentation/Changes file suggest that make-3.78 is new enough to 
build the 2.6.0 kernel:
# grep "make --version"  Documentation/Changes 
o  Gnu make               3.78                    # make --version

I saw reproducable sig segv's with that make at my setup. I ran
the "make all" command in gdb which gave the following output

...
make[2]: Nothing to be done for `__build'.
/usr/local/bin/make -f scripts/Makefile.build obj=net/sunrpc
make[2]: Nothing to be done for `__build'.
/usr/local/bin/make -f scripts/Makefile.build obj=net/unix
make[2]: Nothing to be done for `__build'.
/usr/local/bin/make -f scripts/Makefile.build obj=net/xfrm
make[2]: Nothing to be done for `__build'.
/usr/local/bin/make -f scripts/Makefile.build obj=lib
make[1]: Nothing to be done for `__build'.
/usr/local/bin/make -f scripts/Makefile.build obj=arch/i386/lib
make[1]: Nothing to be done for `__build'.

Program received signal SIGSEGV, Segmentation fault.
expand_argument (
    str=0x8071ebc " echo '  GEN     .version'; . $(srctree)/scripts/mkversion > .tmp_version; mv -f .tmp_version .version; $(MAKE) $(build)=init; ) $(if $($(quiet)cmd_vmlinux__), echo '  $($(quiet)cmd_vmlinux__)' &&) $("..., 
    end=0xffffffff <Address 0xffffffff out of bounds>) at expand.c:417
417       if (*end == '\0')

this happend with make-3.78.

I assume that it only happens with certain environments (e.g. path lengths,
or number and length of enviroment variables and so on). I did not
track that further, but updated to make-3.80 (which is the most 
current release).

So I suggest to lift the requirement in the Documentation/Changes
file. It works here with make-3.80, maybe older version will
work also.

        hope this helps
        Joerg
