Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUJBQrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUJBQrp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUJBQrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:47:45 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:5383 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S267387AbUJBQrm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:47:42 -0400
Date: Sat, 2 Oct 2004 18:48:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap() on cdrom files fails in 2.6.9-rc2-mmX
Message-Id: <20041002184828.2d9fefda.khali@linux-fr.org>
In-Reply-To: <20041002004221.33510f46.akpm@osdl.org>
References: <20040928214246.41b80d30.khali@linux-fr.org>
	<20041002004221.33510f46.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jean Delvare <khali@linux-fr.org> wrote:
> >
> > I think I found a bug in 2.6.9-rc2-mm4. It doesn't seem to be able
> > to mmap() files located on cdroms. Same problem with -mm3 and -mm1.
> > 2.6.9-rc2 works fine. I reproduced it on two completely different
> > systems, so I guess it isn't device dependant.
> > 
> 
> So I tried your .config
> 
> > ...
> > # CONFIG_BLK_DEV_IDECD is not set
> 
> hm.  You're not using an IDE CDROM?
> 
> > CONFIG_BLK_DEV_SR=m
> 
> but you are using a SCSI CDROM, correct?

Correct, on my desktop system. However, I have a laptop with an IDE
CDROM, and am able to reproduce the problem there with 2.6.9-rc2-mm1.

> I tried your test app on both IDE CD with my .config and on SCSI CD
> with your .config.  Works fine.

Mmm, that's odd. There is next to nothing in common between my two
systems (desktop is AMD-based with VIA chipset and SYM/NCR SCSI adapter,
laptop is Intel-based with Intel chipset). Oh, the only common point I
can think of is the underlying Linux distro, namely up-to-date Slackware
9.1.

...

Being admittedly lost, I decided to do the only thing I could...
Starting from 2.6.9-rc2-bk1, I incrementally applied all changesets from
bk1 to bk2 as found on linux.bkbits.net:8080/linux-2.5, and test each
time. I wasted quite a few hours on this, but not in vain. The changeset
triggering the problem is this one:

http://linux.bkbits.net:8080/linux-2.5/cset@1.1891

It looks totally unrelated. As to why it causes a problem to only me,
don't ask, I have no idea.

Does it help?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
