Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUC3JYl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbUC3JY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:24:27 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:25805 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263568AbUC3JX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:23:28 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>, kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][KGDB] Drop 'E' packet support
Date: Tue, 30 Mar 2004 13:38:51 +0530
User-Agent: KMail/1.5
References: <20040329201756.GK2895@smtp.west.cox.net>
In-Reply-To: <20040329201756.GK2895@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403301338.51561.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fine with me.

-Amit

On Tuesday 30 Mar 2004 1:47 am, Tom Rini wrote:
> Hi.  After working on the docs a bit based on the textfile from Anurekh
> Saxena, I'd like to commit the following patch (and similar hunks to the
> i386-lite and x86_64 patch) to drop support for the 'E' packet.
>
> This isn't something supported by stock GDB, nor AFAIK is it something
> that's been submitted for inclusion in GDB.  So I'd really like to drop
> this entirely until it's something gdb CVS supports (and I assume would
> be documented in
> http://sources.redhat.com/gdb/current/onlinedocs/gdb_33.html#SEC656 ).
> I could stand putting off the question for now and putting it in the
> non-lite patches, but I'd really rather not.
>
> If no one objects, I'd like to commit this noon, -0700 on 30 March.
> diff -u linux-2.6.4/kernel/kgdb.c linux-2.6.4/kernel/kgdb.c
> --- linux-2.6.4/kernel/kgdb.c	2004-03-19 08:22:37.147169789 -0700
> +++ linux-2.6.4/kernel/kgdb.c	2004-03-29 13:13:11.440594007 -0700
> @@ -130,11 +130,6 @@
>  }
>
>  void __attribute__ ((weak))
> -    kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
> -{
> -}
> -
> -void __attribute__ ((weak))
>      kgdb_disable_hw_debug(struct pt_regs *regs)
>  {
>  }
> @@ -875,12 +870,6 @@
>  				int_to_threadref(&thref, threadid);
>  				pack_threadid(remcom_out_buffer + 2, &thref);
>  				break;
> -
> -			case 'E':
> -				/* Print exception info */
> -				kgdb_printexceptioninfo(exVector, err_code,
> -							remcom_out_buffer);
> -				break;
>  			case 'T':
>  				if (memcmp(remcom_in_buffer + 1,
>  					   "ThreadExtraInfo,", 16)) {

