Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312581AbSDOCuK>; Sun, 14 Apr 2002 22:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312582AbSDOCuJ>; Sun, 14 Apr 2002 22:50:09 -0400
Received: from hera.cwi.nl ([192.16.191.8]:29605 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312581AbSDOCuH>;
	Sun, 14 Apr 2002 22:50:07 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 15 Apr 2002 02:50:04 GMT
Message-Id: <UTC200204150250.CAA625650.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: IDE / SmartMedia
Cc: mdharm@one-eyed-alien.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The TCQ stuff is definitely experimental, you should probably
> configure it out for now.

% grep TCQ .config
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDE_TCQ_DEFAULT is not set

That was not it. I had not selected DMA. Doing so does not help,
but reveals a new choice, namely support for HPT366.
Selecting CONFIG_BLK_DEV_HPT366 makes the crash go away.

So far about IDE. Marcin wil figure out what went wrong there.



I figured out something else, namely that SDDR09 has a built-in
scatter-gather read command (several pages on the card to a single
memory buffer). Probably also an sg write command,
but I have not found it yet. Let me document in public:

/*
 * Read Scatter Gather Command: 3+4n bytes.
 * byte 0: opcode E7
 * byte 2: n
 * bytes 4i-1,4i,4i+1: page address
 * byte 4i+2: page count
 * (i=1..n)
 */

Finally a question. People tell me that very recently
256MB (2Gb) SmartMedia (NAND flash) cards have appeared.
If someone has one of these already, please tell me -
I would like to know the device type code.

Andries
