Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTJKCr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 22:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbTJKCr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 22:47:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:58793 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263235AbTJKCry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 22:47:54 -0400
Date: Fri, 10 Oct 2003 19:45:08 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Noah J. Misch" <noah@caltech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patches for PROC_FS=n (2.6.0-test7)
Message-Id: <20031010194508.1b0d870e.rddunlap@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0310101519330.9806@inky>
References: <Pine.GSO.4.58.0310101519330.9806@inky>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 16:06:29 -0700 (PDT) "Noah J. Misch" <noah@caltech.edu> wrote:

| > drivers/char/toshiba.c and
| > net/atm/clip.c don't build if PROC_FS=n.
| 
| > Patches for them are available at:
| 
| > http://developer.osdl.org/rddunlap/patches/toshiba_inline_260t7.patch
| 
| Consider the patch at the bottom of this message instead.  The tosh_get_info
| function is really internal to drivers/char/toshiba.c, so instead I changed it
| to static in that file and completely removed the prototype in toshiba.h.
| 
| BTW, both your patch (I think) and mine also solve a duplicate symbol problem -
| see the ChangeSet log for details.

Yes, your patch is good and should be applied.

| > http://developer.osdl.org/rddunlap/patches/atmprocfs_260t7.patch
| 
| Cool.
| 
| > There are several other drivers/protocols that don't build
| > with PROC_FS=n, like arlan, siimage, ipx, llc, and bluetooth.
| 
| I put in a patch for ipx yesterday, and I have patches for siimage and llc
| pretty much ready to go.  I noticed the others but I have not done much.

Good, thanks for the info.

~Randy

| Thanks,
| Noah
| 
| Toshiba patch:
| 
| # This is a BitKeeper generated patch for the following project:
| # Project Name: Linux kernel tree
| # This patch format is intended for GNU patch command version 2.5 or higher.
| # This patch includes the following deltas:
| #	           ChangeSet	1.1344  -> 1.1345
| #	include/linux/toshiba.h	1.3     -> 1.4
| #	drivers/char/toshiba.c	1.11    -> 1.12
| #
| # The following is the BitKeeper ChangeSet Log
| # --------------------------------------------
| # 03/10/10	noah@caltech.edu	1.1345
| # Remove the prototypes for tosh_get_info from include/linux/toshiba.h and
| # make the function's definition in drivers/char/toshiba.c static.  This
| # function is specific to toshiba.c, so no other file needs the prototype.
| #
| # This allows drivers/char/toshiba.c to compile with CONFIG_PROC_FS=n and
| # allows one to link more than one driver that includes toshiba.h into the
| # kernel at the same time without a multiple declaration; for example, both
| # drivers/char/toshiba.c and drivers/video/neofb.c.
| # --------------------------------------------
| #
| diff -Nru a/drivers/char/toshiba.c b/drivers/char/toshiba.c
| --- a/drivers/char/toshiba.c	Fri Oct 10 18:50:17 2003
| +++ b/drivers/char/toshiba.c	Fri Oct 10 18:50:17 2003
| @@ -292,7 +292,7 @@
|   * Print the information for /proc/toshiba
|   */
|  #ifdef CONFIG_PROC_FS
| -int tosh_get_info(char *buffer, char **start, off_t fpos, int length)
| +static int tosh_get_info(char *buffer, char **start, off_t fpos, int length)
|  {
|  	char *temp;
|  	int key;
| diff -Nru a/include/linux/toshiba.h b/include/linux/toshiba.h
| --- a/include/linux/toshiba.h	Fri Oct 10 18:50:17 2003
| +++ b/include/linux/toshiba.h	Fri Oct 10 18:50:17 2003
| @@ -33,13 +33,4 @@
|  	unsigned int edi __attribute__ ((packed));
|  } SMMRegisters;
| 
| -#ifdef CONFIG_PROC_FS
| -static int tosh_get_info(char *, char **, off_t, int);
| -#else /* !CONFIG_PROC_FS */
| -inline int tosh_get_info(char *buffer, char **start, off_t fpos, int lenght)
| -{
| -	return 0;
| -}
| -#endif /* CONFIG_PROC_FS */
| -
|  #endif
| 
| -
