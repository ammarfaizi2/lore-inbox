Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbTLMWDM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 17:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTLMWDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 17:03:12 -0500
Received: from pD9E46935.dip.t-dialin.net ([217.228.105.53]:33802 "EHLO
	single7.hn.org") by vger.kernel.org with ESMTP id S265065AbTLMWDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 17:03:06 -0500
From: Nicolai Lissner <nlissne@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: test11: fd0 with msdos showing garbage
Date: Sat, 13 Dec 2003 23:02:35 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312132302.36999.nlissne@linux01.gwdg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!
While doing a BIOS-Update for my board, I have tried to read/write an 
msdos-formatted disk with kernel 2.6.0-test11. It can be mounted without 
errors - but "ls" shows only garbage. The disk is 100% ok - and can be readed 
with kernel 2.4.x without problems. 

I have done some more investigation with that. I can format a disk with e2fs, 
even with msdos - both *seem* to work correct - data can be stored and readed 
- but if the disk have been formatted with msdos on another system it cannot 
be readed with test11. 
So I started to do a diskimage with "dd if=/dev/fd0 of=disk.image" 
- and found some interesting differences:
While kernel 2.4 produces a file of  1474560 bytes,
test11 produces a file of 737280 bytes only.

Comparing these files I found:

from offset 0x00000000 to 0x000013FF  -- no difference.
but... surprise ! 
The diskimage done with kernel 2.6.0-test11 shows the directory of the disk - 
beginning at offset 0x00001400

while it is expected at position 0x00002600 
(where it can be found when read with kernel 2.4)

The directory is followed by 0x00 bytes - next data is found at offset 
0x00002400 -- data, that can be found at offset 0x00004800 in the original 
image.

I can give more detailed information if needed.

Confused but not hopeless (hey, rest of test11 is works a charme here - :)

Nicolai

