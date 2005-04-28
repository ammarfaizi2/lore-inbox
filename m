Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVD1QLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVD1QLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVD1QLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:11:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:62097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262068AbVD1QLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:11:24 -0400
Date: Thu, 28 Apr 2005 09:11:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: vgoyal@in.ibm.com
Cc: akpm@osdl.org, ebiederm@xmission.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, sharyathi@in.ibm.com
Subject: Re: [Fastboot] Re: Kdump Testing
Message-Id: <20050428091119.73568208.rddunlap@osdl.org>
In-Reply-To: <20050428114416.GA5706@in.ibm.com>
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com>
	<OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com>
	<20050425160925.3a48adc5.rddunlap@osdl.org>
	<20050426085448.GB4234@in.ibm.com>
	<20050427122312.358f5bd6.rddunlap@osdl.org>
	<20050428114416.GA5706@in.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005 17:14:16 +0530
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> > > Can you post a full serial console output of second kernel? That would help.
> > 
> > I did another test run, same kernels (both running and recovery).
> > The recovery kernel got a little further this time, still had
> > Badness and a BUG.
> > 
> > ---
> 
> Ok. I am also able to see this slab corruption occurring on my machine. I can 
> get away with the problem if I disable cachefs support. 
> 
> Infact, I can reproduce the problem if I boot capture kernel normally through 
> BIOS with commandline "mem=64M". Looks like it is generic problem and not
> associated with kexec/kdump. Cachefs might be doing some corruption.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Wheeeeeeeeee.  Great, we (I) can do without cachefs,
and when I do that, kexec + kdump works.
First time that I've seen kdump work.  :)

-rw-r--r--  1 root root 1.0G Apr 28 08:41 oldmem.0428
-r--------  1 root root 960M Apr 28 08:36 vmcore.0428

My (crashing/panic) kernel is built without -g, but gdb
can still tell me this much:

(gdb) bt
#0  0xc010ef95 in crash_get_current_regs ()
#1  0x00000000 in ?? ()
#2  0xee821ea0 in ?? ()
#3  0xee821ea0 in ?? ()
#4  0xee821ea0 in ?? ()
#5  0x00000046 in ?? ()
#6  0x00000000 in ?? ()
#7  0x00000000 in ?? ()
#8  0x00000000 in ?? ()
#9  0xee82c000 in ?? ()
#10 0x00000000 in ?? ()
#11 0xc010ed38 in machine_kexec ()


Thanks for following up, tracking, working on this.

---
~Randy
