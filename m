Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUDPIL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 04:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUDPIL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 04:11:58 -0400
Received: from port-213-148-152-119.reverse.qsc.de ([213.148.152.119]:61268
	"EHLO mbs-software.de") by vger.kernel.org with ESMTP
	id S262720AbUDPIL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 04:11:57 -0400
Date: Fri, 16 Apr 2004 10:11:55 +0200
From: Alex Riesen <ari@mbs-software.de>
To: Michal Wronski <wrona@mat.uni.torun.pl>
Cc: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org
Subject: POSIX message queues, libmqueue: mq_open, mq_unlink
Message-ID: <20040416081155.GB7815@linux-ari.internal>
Reply-To: Alex Riesen <ari@mbs-software.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noticed that mqs were included in the 2.6.6-rc1.

Looking over the code in libmqueue-4.31, I noticed the checks for the
name validity in the mq_open and mq_unlink. Why are they needed?  They
are pointless if the code in kernel depends on the valid name, because
libmqueue can not be the only library using the mq interface (all the
libcs being the next candidates), and they are pointless in case the
kernel does not depend on them, because it will return an error anyway,
if that is defined by the implementation.
Can the checks be removed? Cutting of the first character will become
unconditional than, btw, which is also not good.

The other thing: mq_open gets the last two args (attr and mode)
unconditionally. What will the kernel code get in the arguments if
O_CREAT is not specified, and the calling code did not given the
arguments?
I don't think this will ever cause any problem, but the code is unclean
in this aspect.

Sincerely,
Alex Riesen
