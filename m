Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264503AbRFJHa3>; Sun, 10 Jun 2001 03:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264504AbRFJHaT>; Sun, 10 Jun 2001 03:30:19 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:22769 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S264503AbRFJHaN>;
	Sun, 10 Jun 2001 03:30:13 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Frank Davis <fdavis112@juno.com>
cc: Mr Miles T Lane <miles_lane@yahoo.com>, Gergely Madarasz <gorgo@itc.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac12 -- Unresolved symbols in drivers/net/wan/comx.o -- "proc_get_inode" 
In-Reply-To: Your message of "Sun, 10 Jun 2001 03:12:06 -0400."
             <388621635.992157131964.JavaMail.root@web395-wra.mail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Jun 2001 17:30:27 +1000
Message-ID: <13137.992158227@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2001 03:12:06 -0400 (EDT), 
Frank Davis <fdavis112@juno.com> wrote:
>   It appears that fs/proc/inode.o (where proc_get_inode() is defined)
>is not being included when comx.o is built . Keith, I'm not too familar
>the build's dependencies process to know if drivers/net/wan/Makefile
>should be modified or another build file.

One long line of 255 characters reformatted for readability.  Also your
mailer appended Miles's original text without any attribution and
without quoting it, making it look as though you (Frank Davis) wrote
the bug report.  You need a better mailer for linux-kernel.  Having
got that off my chest (and added attribution and quoting) ...

>Miles T Lane wrote
>>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i
>>-r ln -sf ../{} pcmcia
>>if [ -r System.map ]; then /sbin/depmod -ae -F
>>System.map  2.4.5-ac12; fi
>>depmod: *** Unresolved symbols in
>>/lib/modules/2.4.5-ac12/kernel/drivers/net/wan/comx.o
>>depmod: 	proc_get_inode

fs/proc/inode.c is included, it is a fundamental part of /proc.  The
problem is that proc_get_inode is not listed as an exported symbol.
Interesting that nobody else has reported this, proc_get_inode has
never been exported in the 2.4 series and comx.c has not changed in
this area either, looks like nobody else has tried to run comx as a
module.

The obvious fix is to add EXPORT_SYMBOL(proc_get_inode) to
fs/proc/root.c but I am not sure that the obvious fix is the correct
one.  All the other uses of proc_get_inode are in the proc system,
should another subsystem be delving into proc internals?  I'm going to
bounce this one to the proc and comx maintainers to let them decide
amongst themselves.  Hmmm, no official proc maintainer so it's off to
l-k for this mail.

