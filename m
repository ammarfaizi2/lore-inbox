Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUDDT6F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 15:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUDDT6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 15:58:05 -0400
Received: from webmail.sub.ru ([213.247.139.22]:53254 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S262730AbUDDT6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 15:58:01 -0400
Subject: Re: 2.6.4 : 100% CPU use on EIDE disk operarion, VIA chipset
From: Mikhail Ramendik <mr@ramendik.ru>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <406FC621.1090507@A88da.a.pppool.de>
References: <fa.g80v5s8.b2ofhi@ifi.uio.no> <fa.ljb660n.d2ofa9@ifi.uio.no>
	 <406FC621.1090507@A88da.a.pppool.de>
Content-Type: text/plain
Message-Id: <1081108674.1072.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-6aspMR) 
Date: Sun, 04 Apr 2004 23:57:55 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andreas Hartmann wrote:
> > As recommended there, I have tried 2.6.5-rc3-mm4.
> > 
> > No change. Still 100% CPU usage; the performance seems teh same.
> 
> Yes. But it's curious:
> Take a tar-file, e.g. tar the compiled 2.6 kernel directory. Than, untar 
> it again - the machine behaves total normaly. 

Not really. I tried a "simple" tar (no gzib/bzip2) - it was the same as
with cp, a near-100% CPU "system" load, most of it iowait.

If I use bzip2 with tar, then yes, the load is nearly 100% "user",
actually it's bzip2. But this is because the disk i/o is done at a *far*
slower rate; the bottleneck is the CPU. If we don't read (or write) the
disk heavily, naturally the system/iowait load is low.

I tried doing a "cp" in another xterm window, while the tar/bzip2 was
running. And sure enough, up the CPU system/iowait usage goes - the
"cp"'s disk i/o takes much of the CPU time away from the bz2 task! Looks
exactly like a cause of performance problems.

(All of this was done on 2.6.5-rc3-mm4).

Yours, Mikhail Ramendik



> And the 2.6-kernel is about 
> 23% faster than the 2.4-kernel.
> 
> 
> > Yours, Mikhail Ramendik
> > 
> > P.S. Sorry for making all comments into answers to your letter. I just
> > don't want to break the thread. 
> 
> No problem - it's easier to read with comment directly in the text.
> 
> 
> Regards,
> Andreas Hartmann
> 
> 


