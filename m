Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbUJZHfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbUJZHfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbUJZHfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:35:36 -0400
Received: from mproxy.gmail.com ([216.239.56.241]:25569 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262163AbUJZHed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:34:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Byh2j0w9VEPhGkXEoIcHV5Qa+WJkcL0Rv29IP4SehBiRzSQ1EF2wHNykYEnwcJoxssrzk7stjIByiOVmqAWKWoqpBUASdi0WmRKL3h8Lvj1ztYlJyshqJshsOP/LDh8qIDGYWuLDR9Jtc2huMUrj/SsoNT9nrntZ+WVb02jvL78=
Message-ID: <21d7e99704102600347d8f6f8f@mail.gmail.com>
Date: Tue, 26 Oct 2004 17:34:29 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Serial console blocking processes in write
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a system running a 2.6.9-rc1-VP-R0 (it also happens with
2.6.6 vanilla though) kernel, and a busybox 1.00-pre8 along with about
4-5 user space processes all talking out through a serial console
(/dev/ttyS0).

After about 2-3 hours of constant stuff streaming out of the serial
port, my apps all hang on writes to the fd for stderr, (2->/dev/ttyS0
in /proc/<pid>/fd). busybox seems to initially open the ttyS0 device
as O_NONBLOCK so I would assume this propogates down to my
applications as they are fork/execed by busybox.

However my kernel printks keep coming out the serial port quite happily.

If I then type any character on the other end of the console, I get
16-bytes of data (a FIFO load) sent, so if I keep transmitting chars
to the other end, I get 16-bytes for every char and eventually the log
jams seems to clear and it runs again fine for another 2-3 hours until
it seems to happen again.

Any ideas where to start looking, my debugging env is quite crap, but
I'm trying to get space on the flash to throw gdb and switch on a lot
more debugging, at the moment I've gotten busybox telnetd that I can
startup after it crashes, and strace shows be everyone stuck in the
writes....

Dave.
