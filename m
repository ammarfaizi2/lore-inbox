Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265913AbUFVU2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUFVU2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUFVUZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:25:52 -0400
Received: from [195.150.161.140] ([195.150.161.140]:4100 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S265484AbUFVUVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:21:04 -0400
Date: Tue, 22 Jun 2004 22:20:32 +0200 (CEST)
From: =?ISO-8859-2?Q?Maciej_=AFenczykowski?= <maze@cela.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.27-rc1 pipes - file -z hangs on some gzip files
Message-ID: <Pine.LNX.4.58LT.0406222137100.12146@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I'm investigating a weird hang of file -z (both newest version from Fedora 
Core 1 [4.02] and from Fedora Core 2 [4.07]) on a 2.4.27-rc1 kernel.

file -z reiserfs.o.gz hangs, strace -f file -z reiserfs.o.gz shows the 
following end fragment.
The same file binary [the 4.07 one] works on this file on a 2.6 kernel 
(the current default from FC2) but on a different system.

The problem appears to be pipe related.

[the data is correctly compressed, decompressed correctly, and I have two 
compressed files that behave this way]

[pid 1033 is the file command, pid 1034 is gzip -cdq subprocess, piped 
i/o]

[pid  1033] close(4)                    = 0
[pid  1033] close(7)                    = 0
[pid  1033] write(5, 
"\37\213\10\10_\207\330@\2\3reiserfs.o\0\314\375\v|T\325"..., 65536 
<unfinished ...>
[pid  1034] <... read resumed> 
"\37\213\10\10_\207\330@\2\3reiserfs.o\0\314\375\v|T\325"..., 32768)
= 32768
[pid  1034] brk(0)                      = 0x80a6f70
[pid  1034] brk(0x80c7f70)              = 0x80c7f70
[pid  1034] brk(0)                      = 0x80c7f70
[pid  1034] brk(0x80c8000)              = 0x80c8000
[pid  1034] brk(0)                      = 0x80c8000
[pid  1034] brk(0)                      = 0x80c8000
[pid  1034] brk(0x80c7000)              = 0x80c7000
[pid  1034] brk(0)                      = 0x80c7000
[pid  1034] write(1, 
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0"..., 32768

is this a kernel problem? shared library problem (libz?), any ideas?

Thanks,
MaZe.

