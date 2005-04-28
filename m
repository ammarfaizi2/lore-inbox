Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVD1TNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVD1TNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVD1TNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:13:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6090 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262234AbVD1TNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:13:35 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: vgoyal@in.ibm.com, akpm@osdl.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, sharyathi@in.ibm.com
Subject: Re: [Fastboot] Re: Kdump Testing
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com>
	<OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com>
	<20050425160925.3a48adc5.rddunlap@osdl.org>
	<20050426085448.GB4234@in.ibm.com>
	<20050427122312.358f5bd6.rddunlap@osdl.org>
	<20050428114416.GA5706@in.ibm.com>
	<20050428091119.73568208.rddunlap@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Apr 2005 13:08:29 -0600
In-Reply-To: <20050428091119.73568208.rddunlap@osdl.org>
Message-ID: <m1mzri90sy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> On Thu, 28 Apr 2005 17:14:16 +0530
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > > > Can you post a full serial console output of second kernel? That would
> help.
> 
> > > 
> > > I did another test run, same kernels (both running and recovery).
> > > The recovery kernel got a little further this time, still had
> > > Badness and a BUG.
> > > 
> > > ---
> > 
> > Ok. I am also able to see this slab corruption occurring on my machine. I can
> 
> > get away with the problem if I disable cachefs support. 
> > 
> > Infact, I can reproduce the problem if I boot capture kernel normally through
> 
> > BIOS with commandline "mem=64M". Looks like it is generic problem and not
> > associated with kexec/kdump. Cachefs might be doing some corruption.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Wheeeeeeeeee.  Great, we (I) can do without cachefs,
> and when I do that, kexec + kdump works.
> First time that I've seen kdump work.  :)
> 
> -rw-r--r--  1 root root 1.0G Apr 28 08:41 oldmem.0428
> -r--------  1 root root 960M Apr 28 08:36 vmcore.0428
> 
> My (crashing/panic) kernel is built without -g, but gdb
> can still tell me this much:
> 
> (gdb) bt
> #0  0xc010ef95 in crash_get_current_regs ()
> #1  0x00000000 in ?? ()
> #2  0xee821ea0 in ?? ()
> #3  0xee821ea0 in ?? ()
> #4  0xee821ea0 in ?? ()
> #5  0x00000046 in ?? ()
> #6  0x00000000 in ?? ()
> #7  0x00000000 in ?? ()
> #8  0x00000000 in ?? ()
> #9  0xee82c000 in ?? ()
> #10 0x00000000 in ?? ()
> #11 0xc010ed38 in machine_kexec ()
> 
> 
> Thanks for following up, tracking, working on this.

Congratulations everyone.  The good really good news is when the
recovery kernel failed it failed early enough it did not make things
worse.  It is good to see that prediction confirmed :)

Eric
