Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTDZQAl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbTDZQAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:00:41 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:17680 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S261807AbTDZQAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:00:39 -0400
Date: Sat, 26 Apr 2003 18:12:53 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4 NFS file corruption
Message-ID: <Pine.LNX.4.44.0304261742200.18264-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear experts!

I'm seeing very strange file corruption, with parts of the data (most of the 
bytes, actually) being correct, but some being 0x00 and others (few) being 
something else. The strangest thing however is that this affected exactly the 
complete first 4kB page of the file.

The server and clients run CERN RedHat 7.3.2, which is based on RedHat 7.3 and 
has a 2.4.18 kernel with patches upto the 2.4.21-pre5 range. If you need the 
list of patches I can look it up and will happily supply it.

Here's a sample hexdump:

good:

000000 7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
000010 02 00 03 00 01 00 00 00 e0 80 04 08 34 00 00 00
000020 70 fa 65 00 00 00 00 00 34 00 20 00 03 00 28 00
000030 16 00 13 00 01 00 00 00 00 00 00 00 00 80 04 08
000040 00 80 04 08 0c 23 0f 00 0c 23 0f 00 05 00 00 00
000050 00 10 00 00 01 00 00 00 20 23 0f 00 20 b3 13 08
000060 20 b3 13 08 38 80 03 00 30 ba 04 00 06 00 00 00
000070 00 10 00 00 04 00 00 00 94 00 00 00 94 80 04 08
000080 94 80 04 08 20 00 00 00 20 00 00 00 04 00 00 00
000090 04 00 00 00 04 00 00 00 10 00 00 00 01 00 00 00
0000a0 47 4e 55 00 00 00 00 00 02 00 00 00 02 00 00 00
0000b0 05 00 00 00 55 89 e5 83 ec 08 e8 45 00 00 00 90
0000c0 e8 db 00 00 00 e8 16 51 0d 00 c9 c3 00 00 00 00
0000d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0000e0 31 ed 5e 89 e1 83 e4 f0 50 54 52 68 20 d3 11 08
0000f0 68 b4 80 04 08 51 56 68 b4 91 04 08 e8 df 91 07

bad:

000000 7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
000010 02 00 03 00 01 00 00 00 80 10 05 08 34 00 00 00
000020 20 e9 44 00 00 00 00 00 34 00 20 00 06 00 28 00
000030 1f 00 1c 00 06 00 00 00 34 00 00 00 34 80 04 08
000040 34 80 04 08 c0 00 00 00 c0 00 00 00 05 00 00 00
000050 04 00 00 00 03 00 00 00 f4 00 00 00 f4 80 04 08
000060 f4 80 04 08 13 00 00 00 13 00 00 00 04 00 00 00
000070 01 00 00 00 01 00 00 00 00 00 00 00 00 80 04 08
000080 00 80 04 08 38 de 04 00 38 de 04 00 05 00 00 00
000090 00 10 00 00 01 00 00 00 40 de 04 00 40 6e 09 08
0000a0 40 6e 09 08 8c 85 02 00 04 8a 02 00 06 00 00 00
0000b0 00 10 00 00 02 00 00 00 ec 62 07 00 ec f2 0b 08
0000c0 ec f2 0b 08 e0 00 00 00 e0 00 00 00 06 00 00 00
0000d0 04 00 00 00 04 00 00 00 08 01 00 00 08 81 04 08
0000e0 08 81 04 08 20 00 00 00 20 00 00 00 04 00 00 00
0000f0 04 00 00 00 2f 6c 69 62 2f 6c 64 2d 6c 69 6e 75

What puzzles me most is that I have 16 NFS clients, 9 seeing the correct file 
contents, while all others see the same corrupted image. The sequence of 
events to get the corruption is:

1) copy the file onto the server's exported directory
2) create a symlink to it from the same directory
3) execute the file
4) process crashes, gets restated (repeatedly, because of corruption)
5) machine is rebooted, everything works fine for several hours
6) restart at 4)

While in this circle, the file was overwritten several times with updated 
versions.

These troubles were not observed when the clients were still running RedHat 
6.1 (kernel 2.2.19).

Thanks for your reply,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

"If you think NT is the answer, you didn't understand the question."
						- Paul Stephens

