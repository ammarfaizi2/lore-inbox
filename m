Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUBZKba (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 05:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbUBZKba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 05:31:30 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:63499 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262758AbUBZKbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 05:31:23 -0500
Date: Thu, 26 Feb 2004 21:31:03 +1100
To: Roland Stigge <stigge@antcom.de>, 234754@bugs.debian.org
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234754: kernel-source-2.6.3: Badness on Software Suspend
Message-ID: <20040226103103.GE18970@gondor.apana.org.au>
References: <20040225164521.1CA5E10010D5F@atari.stigge.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20040225164521.1CA5E10010D5F@atari.stigge.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tags 234754 pending
quit

On Wed, Feb 25, 2004 at 05:45:20PM +0100, Roland Stigge wrote:
> Package: kernel-source-2.6.3
> Version: 2.6.3-2
> Severity: normal
> 
> on Software Suspend (echo 4 >/proc/acpi/sleep), I get Badness messages
> written to my screen (and syslog). I attached the syslog excerpt and the
> boot messages.

> Feb 25 17:29:26 bird kernel: Fixing swap signatures... ok
> Feb 25 17:29:26 bird kernel: Badness in redraw_screen at drivers/char/vt.c:607
> Feb 25 17:29:26 bird kernel: Call Trace:
> Feb 25 17:29:26 bird kernel:  [redraw_screen+496/501] redraw_screen+0x1f0/0x1f5
> Feb 25 17:29:26 bird kernel:  [do_magic_resume_2+209/246] do_magic_resume_2+0xd1/0xf6

This patch should shut it up.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-2.5/kernel/power/swsusp.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/kernel/power/swsusp.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 swsusp.c
--- kernel-2.5/kernel/power/swsusp.c	19 Feb 2004 08:56:02 -0000	1.1.1.6
+++ kernel-2.5/kernel/power/swsusp.c	26 Feb 2004 10:26:21 -0000
@@ -619,7 +619,9 @@
 	PRINTK( "ok\n" );
 
 #ifdef SUSPEND_CONSOLE
+	acquire_console_sem();
 	update_screen(fg_console);	/* Hmm, is this the problem? */
+	release_console_sem();
 #endif
 }
 

--PEIAKu/WMn1b1Hv9--
