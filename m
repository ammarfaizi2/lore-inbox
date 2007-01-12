Return-Path: <linux-kernel-owner+w=401wt.eu-S1161109AbXALWeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbXALWeG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbXALWeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:34:06 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:35179 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161109AbXALWeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:34:04 -0500
Date: Fri, 12 Jan 2007 23:31:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Erik Mouw <erik@harddisk-recovery.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, congwen <congwen@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How can I create or read/write a file in linux device driver?
In-Reply-To: <Pine.LNX.4.61.0701120907430.23919@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0701122329000.19224@yvahk01.tjqt.qr>
References: <200701121547221465420@gmail.com>
 <9a8748490701120227h757d473ctaf5673aa318fe090@mail.gmail.com>
 <20070112132459.GY13675@harddisk-recovery.com> <Pine.LNX.4.61.0701120907430.23919@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 12 2007 09:27, linux-os (Dick Johnson) wrote:
>
>First, since file-operations require process context, and the kernel
>is not a process, you need to create a kernel thread to handle your file
>I/O.

Not always. If you do file I/O as part of a device driver, you are fine.
quad_dsp is such an example, where writing to /dev/Qdsp_* will trigger writes
to /dev/dsp and /dev/adsp.

>Once you set up this "internal environment," you use the appropriate
>kernel function(s) such as sys_open()

What against filp_open? That avoids the unnecessary getname() stuff in most
syscalls.


	-`J'
-- 
