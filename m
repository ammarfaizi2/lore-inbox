Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135380AbRAHJdr>; Mon, 8 Jan 2001 04:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRAHJdi>; Mon, 8 Jan 2001 04:33:38 -0500
Received: from node1.teliafi.net ([195.10.132.101]:24231 "EHLO
	mbox.teliafi.net") by vger.kernel.org with ESMTP id <S135380AbRAHJdc>;
	Mon, 8 Jan 2001 04:33:32 -0500
Date: Mon, 08 Jan 2001 11:33:28 +0200
From: Aschwin van der Woude <aschwin@sofis.fi>
Subject: Re: Kernel halts rock solid on assigning ip (ne2k-pci)
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, becker@scyld.com,
        linux-net@vger.kernel.org,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Message-id: <3A598968.8B043B34@sofis.fi>
Organization: Sofis design
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.4.0-test10 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <3A55D540.1FA574D9@sofis.fi> <3A56E983.343007BC@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker wrote:
> 
> Aschwin van der Woude wrote:
> >
> > I have a problem with a network-driver.
> > The ne2k-pci modules loads fine, no problem at all. Everything works
> > like a sunshine.
> > But as soon as I try to assign an IP-adress the whole system halts
> > rock-solid, the magic sysrq combinations don't even work anymore.
> >
> > I am not sure if this is due to an IRQ-conflict. But I do know it all
> > happens to work perfectly fine with 2.4.0-test10. This happens on both
> > 2.4.0-prerelease and the 2.4.0-kernel.
> >
> > I attached some info about my configuration. I hope you/somebody can
> > help me solve this, I am eager to start using 2.4.0.
> > So far I have been very happy using 2.4.0-test10.
> 
> The test11 patch has the ne2k-pci changes for FD support, and the
> test12 patch has the Tx timeout relocation in 8390 (which ne2k-pci
> uses).  Can you see which one of those (if either) causes the
> breakage?  You should be able to put the 8390.c and ne2k-pci.c
> from test10 directly into 2.4.0 proper (one at a time and then
> both if required) to see which (if either) is responsible.

Hmm. I tried your suggestion but with no luck. Might it there be another
source for my problem.
Here is how I tried it :

# cd /usr/src/linux-2.4.0/drivers/net
# mv 8390.c 8390.c.bck
# mv 8390.h 8390.h.bck
# ln -s /usr/src/linux-2.4.0-test10/drivers/net/8390.c
/usr/src/linux-2.4.0/drivers/net/8390.c
# ln -s /usr/src/linux-2.4.0-test10/drivers/net/8390.h
/usr/src/linux-2.4.0/drivers/net/8390.h
# mv ne2k-pci.c ne2k-pci.c.bck
# ln -s /usr/src/linux-2.4.0-test10/drivers/net/ne2k-pci.c
/usr/src/linux-2.4.0/drivers/net/ne2k-pci.c
# cd /usr/src/linux-2.4.0
# make dep
# make modules
# make modules_install

I did try 8390 only at first. The problem remains. Unabling the
bios-setting 'PnP OS' doesn't have any effect.
The modules load fine without problems.
I hoped this would have solved my problem, but no such luck. Did I do
something wrong. I am no kernel or C expert, altough I can read and
modify C and have been following kernel-development for quite a while.

Thanks,

Aschwin


-- 
"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
