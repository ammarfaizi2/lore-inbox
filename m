Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbTADJXp>; Sat, 4 Jan 2003 04:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266749AbTADJXp>; Sat, 4 Jan 2003 04:23:45 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:27018 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266735AbTADJXo>; Sat, 4 Jan 2003 04:23:44 -0500
Subject: [PATCH] Make ide-probe more robust to non-ready devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1041672876.1346.23.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 04 Jan 2003 10:34:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan !

I've needed this patch (well, this is a cleaned up version of what I
used actually) for some time on PPC and on some embedded platforms. The
issue that typically happens is when the kernel is booted with an IDE
device still doing it's POST sequence (or just beeing reset, that is
with no firmware or a firmware that doesn't wait for the device to be
ready before booting the kernel).

The patch just waits up to 35 seconds (30 seconds per spec, plus a small
margin to deal with a couple of bogus drives I saw that took 31 seconds)
for the BUSY bit to go away on an HWIF.

It's mandatory in the IDE spec to pull-down D7 to ground on an inteface,
so that an interface with no driver connected should return a value with
bit BUSY 0x80 cleared, thus will not trigger this wait loop. I did a
sanity check against 0xff anyway to deal with a couple of bogus
interfaces I encountered though.

I don't expect this patch to break any existing working configuration,
so please send to Linus for 2.5. If you accept it, I'll then send a 2.4
version to Marcelo as well. This have been around for some time and,
imho, should really get in now.

Regards,
Ben.

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

