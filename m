Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbSL3XBc>; Mon, 30 Dec 2002 18:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbSL3XBc>; Mon, 30 Dec 2002 18:01:32 -0500
Received: from mailproxy1.netcologne.de ([194.8.194.222]:36743 "EHLO
	mailproxy1.netcologne.de") by vger.kernel.org with ESMTP
	id <S267059AbSL3XBa> convert rfc822-to-8bit; Mon, 30 Dec 2002 18:01:30 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?J=F6rg=20Prante?= <joergprante@netcologne.de>
Reply-To: joergprante@netcologne.de
To: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCHSET] 2.4.21-pre2-jp15
Date: Tue, 31 Dec 2002 00:08:27 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, jp-kernel@infolinux.de
References: <4.3.2.7.2.20021230213831.00b5b250@pop.t-online.de>
In-Reply-To: <4.3.2.7.2.20021230213831.00b5b250@pop.t-online.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212310008.27029.joergprante@netcologne.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Margit,

> 	No, the defines in sched.h are surrounded by #idef CONFIG_PREEMPT
> 	before #ifdef CONFIG_PREEMPT_LOG and therefore don't bite.

The surrounding is correct. You can't get into an error because the 
configuration claims

   dep_bool '  Preemption logging' CONFIG_PREEMPT_LOG $CONFIG_PREEMPT

so I guess your configuration is bad.

> scx200.c:117: parse error before
> "this_object_must_be_defined_as_export_objs_in_the_Makefile"

Here is a fix:

http://infolinux.de/jp15/077_scx200-export-fix

> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> pcmcia if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
> 2.4.21mw0; fi depmod: *** Unresolved symbols in
> /lib/modules/2.4.21mw0/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode

>From the documentation:
"You must say Y to "/proc file system support" (CONFIG_PROC_FS) to
use this driver."

If you managed to build procfs as a module, which is unusual, try this fix:

http://infolinux.de/jp15/078_proc-inode-export

> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21mw0/kernel/net/irda/irda.o depmod:        
> irlmp_lap_tx_queue_full

This is a bug introduced by 2.4.21-pre2.

Here is a fix:

http://infolinux.de/jp15/079_irttp-fix

Jörg
