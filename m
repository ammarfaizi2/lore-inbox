Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284711AbRLRTJy>; Tue, 18 Dec 2001 14:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284775AbRLRTGs>; Tue, 18 Dec 2001 14:06:48 -0500
Received: from pc3-stoc4-0-cust138.mid.cable.ntl.com ([213.107.175.138]:45316
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S284759AbRLRTG1>; Tue, 18 Dec 2001 14:06:27 -0500
Date: Tue, 18 Dec 2001 19:06:21 +0000
From: Ian Chilton <ian@ichilton.co.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.4.17-rc1 wont do nfs root on Javastation
Message-ID: <20011218190621.A28147@buzz.ichilton.local>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
In-Reply-To: <20011214181816.B28794@woody.ichilton.co.uk> <20011215.220646.69411478.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011215.220646.69411478.davem@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Add "root=nfs" to your kernel command line.

I checked with Pete and as I suspected, putting kernel parameters on the
command line doesn't work as proll just drops them.

So, I made a bit of a hack:

[ian@slinky:~/tmp/js/linux/arch/sparc/kernel]$ diff -u setup.c.orig
setup.c
--- setup.c.orig        Sat Nov 17 00:30:25 2001
+++ setup.c     Tue Dec 18 19:44:16 2001
@@ -306,6 +306,10 @@
 
        /* Initialize PROM console and command line. */
        *cmdline_p = prom_getbootargs();
+
+       /* Hack to hard code root=nfs. */
+       strcat(*cmdline_p,"root=nfs");
+
        strcpy(saved_command_line, *cmdline_p);
 
        /* Set sparc_cpu_model */


Now when it boots, it says "Kernel command line: root=nfs" but still,
the kernel does not try and do the IP-Config/bootp stuff so it fails
saying it can't find the NFS server which is obvious as it doesn't have
an ip etc...


Any other ideas?


Thanks!

Ian

