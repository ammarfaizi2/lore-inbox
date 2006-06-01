Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWFAW6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWFAW6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWFAW6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:58:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750854AbWFAW6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:58:23 -0400
Date: Thu, 1 Jun 2006 16:00:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: jonsmirl@gmail.com, dhazelton@enter.net, dlang@digitalinsight.com,
       santiago@mail.cz, airlied@gmail.com, pavel@ucw.cz,
       alan@lxorguk.ukuu.org.uk, mrmacman_g4@mac.com, abraham.manu@gmail.com,
       linuxcbon@yahoo.fr, helge.hafting@aitel.hist.no,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-Id: <20060601160045.1638473a.akpm@osdl.org>
In-Reply-To: <447F56A0.8030408@gmail.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	<9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
	<Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>
	<200606011603.57421.dhazelton@enter.net>
	<9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
	<447F56A0.8030408@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> Console writes are done with the console semaphore held. printk will also
> just write to the log buffer and defer the actual console printing
> for later, by the next or current process that will grab the semaphore.

Always by the current process which holds console_sem.  Leaving the printing
for the next process would be unacceptably too late for printk.

If printk sees that someone holds console_sem, printk will leave the data
in the log buffer for the current holder of console_sem to print, prior to
that caller releasing console_sem.  logbuf_log is used in tricky ways
around console_sem to prevent races in this logic.
