Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278491AbRJVKly>; Mon, 22 Oct 2001 06:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278492AbRJVKlt>; Mon, 22 Oct 2001 06:41:49 -0400
Received: from camus.xss.co.at ([194.152.162.19]:31756 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S278491AbRJVKkk>;
	Mon, 22 Oct 2001 06:40:40 -0400
Message-ID: <3BD3F7C7.A7FE0BD6@xss.co.at>
Date: Mon, 22 Oct 2001 12:41:11 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20pre10
In-Reply-To: <20011022112149.A5625@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Alan Cox wrote:
> 
> Things took a bit longer than intended with various security fixes needing to
> be done. If this tree tests out ok it will be 2.2.20
> 
> 2.2.20pre11
> o       Security fixes
>         | Details censored in accordance with the US DMCA
> o       Sparc updates                                   (Dave Miller)
> o       Add escaped usb hot plug config item            (Ryan Maple)
> o       Fix eepro10 driver problems                     (Aris)
> o       Make request_module return match 2.4            (David Woodhouse)
> o       Update SiS900 driver                            (Hui-Fen Hsu)
> o       Update ver_linux to match 2.4                   (Steven Cole)
> o       Final isdn fixups for 2.2                       (Kai Germaschewski)
> o       scsi tape fixes from 2.4                        (Kai Mäkisara)
> o       Update credits entry                            (Henrik Storner)
> o       Fix scc driver hang case                        (Jeroen)
> o       Update credits entry                            (Dave Jones)
> o       Update FAT documentation                        (Hirokazu Nomoto)
> o       Small net tweaks                                (Dave Miller)
> o       Fix cs89xx abuse of skb->len                    (Kapr Johnik)

Any reason for my one-liner patch to linux/net/sunrpc/sched.c
is still not included?

andreas@ws1:~/cvsdir {625} % cvs diff -C5 -rR_2-2-19~11 -rR_2-2-19~12
linux/net/sunrpc/sched.c
Index: linux/net/sunrpc/sched.c
===================================================================
RCS file:
/raid5/cvs/repository/distribution/Base/linux/net/sunrpc/sched.c,v
retrieving revision 1.1.1.6
retrieving revision 1.12
diff -C5 -r1.1.1.6 -r1.12
*** linux/net/sunrpc/sched.c    2001/03/25 16:37:42     1.1.1.6
--- linux/net/sunrpc/sched.c    2001/08/17 11:53:48     1.12
***************
*** 1066,1075 ****
--- 1066,1076 ----
        rpciod_pid = current->pid;
        up(&rpciod_running);
 
        exit_files(current);
        exit_mm(current);
+       exit_fs(current);
 
        spin_lock_irq(&current->sigmask_lock);
        siginitsetinv(&current->blocked, sigmask(SIGKILL));
        recalc_sigpending(current);
        spin_unlock_irq(&current->sigmask_lock); 

Without this patch, rpciod keeps the initial ramdisk rootfs
busy on our diskless clients, so we cannot umount and free
it...

Regards,

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
