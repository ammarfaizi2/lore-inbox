Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWD3TTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWD3TTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 15:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWD3TTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 15:19:52 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:56964 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750983AbWD3TTv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 15:19:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D1J8YUbuIpV1U3C/n1YhMuwqZuB4cdWcbRxMgvm5PwJ1zrmHaCrCRfbdWvBZ81Y/aFrSZ+hPbx03coW1ZAEcwG0sl5h7nM2Lie+DPLkpR5ln2p6JHBVqRH51p6U4+01pXig2CcChTzARNacKQbavzoJxVB8XWvJNp7R0g20WhkU=
Message-ID: <2a56523e0604301219s67244272n7e8ee7c634a1933c@mail.gmail.com>
Date: Sun, 30 Apr 2006 12:19:50 -0700
From: "Professor Moriarty" <bofh.h4x@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: irq event 5: bogus return value 19
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On debugging a soundcard driver (the Riptide driver from linuxant,
ported by me to 2.6), I seem to have 2 weird bugs that are giving me a
headache:
Both occur when I try to actually play a file
The first: ppos != &file->f_pos
If I comment that check out, I get a kernelpanic. If I comment out the
schedule_work() to run the bottom half of the IRQ handler, I get the
message:
irq event 5: bogus return value 19
Followed by:
kernel: Disabling IRQ #5
At this point, the first 4K of raw PCM plays, and then /dev/dsp
blocks, while the speakers repeat the 4K of data repeatedly until I
ctrl+C mplayer. Trying to cat data to /dev/dsp plays first 4K, then
cat says /dev/dsp is out of space.

Any ideas?

~ Vasily Ivanov
