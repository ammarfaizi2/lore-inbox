Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318198AbSHDUE3>; Sun, 4 Aug 2002 16:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSHDUE3>; Sun, 4 Aug 2002 16:04:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21999 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S318198AbSHDUE3>;
	Sun, 4 Aug 2002 16:04:29 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 4 Aug 2002 22:07:57 +0200 (MEST)
Message-Id: <UTC200208042007.g74K7vV14693.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, greg@kroah.com
Subject: Re: usb devicefs flaw
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix is already in Linus's tree, thanks to David Brownell

Good!
For myself I had made the fix with * instead of /.
But yes, 0 is unambiguous.

Another problem that I see under not yet determined circumstances
is "Too many links" when I do "cat product" or "cat manufacturer"
for some USB device in the devicefs tree.
This -EMLINK smells like some random negative number.
Now usb_string() in usb/core/message.c can return an error,
but routines like show_product() and show_manufacturer()
in usb/core/usb.c blindly do
	len = usb_string(...);
	buf[len] = '\n';
	buf[len+1] = 0x00;
	return len+1;
so that in case of an error some random memory is corrupted.
In other words: everywhere the return value of usb_string()
must be checked.

Andries


[Concerning the -EMLINK, I bet that usb_string() returned -EPIPE
which is -32, so that here -31, that is, -EMLINK, is returned.]
