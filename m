Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271346AbRHQKs7>; Fri, 17 Aug 2001 06:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271350AbRHQKst>; Fri, 17 Aug 2001 06:48:49 -0400
Received: from camus.xss.co.at ([194.152.162.19]:29715 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S271346AbRHQKsh>;
	Fri, 17 Aug 2001 06:48:37 -0400
Message-ID: <3B7CF68D.9694DD53@xss.co.at>
Date: Fri, 17 Aug 2001 12:48:45 +0200
From: Daniel Wagner <daniel.wagner@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: initrd: couldn't umount
In-Reply-To: <E15Xgr3-000775-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > the problem is that a "rpciod" kernel-thread references the initrd,
> > and so umounting and freeing it, isn't possible.
> >
> > has anybody an idea how to fix this problem, cause it would be nice,
> > to free the initrd ram on a diskless node.
> 
> It shouldnt be keeping a reference. daemonize() should have dropped its
> resources

hmm, i've now created a /initrd directory to let the the change_root of
the
initrd work correctly.

and then i looked with fuser, what processes reference the initrd:

---
root@ws4:~ $ fuser -mv /initrd/
 
                     USER        PID ACCESS COMMAND
/initrd/             root         67 .rc.. 
rpciod                                                                                         
---

only the rpciod references the initrd, none of the other
kernel-threads.

Regards,
  Daniel

-- 
Daniel Wagner                      | mailto:daniel@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
