Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWIIKnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWIIKnl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 06:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWIIKnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 06:43:41 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:64775 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751220AbWIIKnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 06:43:40 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Oops after 30 days of uptime
Date: Sat, 9 Sep 2006 12:43:38 +0200
User-Agent: KMail/1.9.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaber@trash.net
References: <200609011852.39572.linux@rainbow-software.org> <200609091215.26617.linux@rainbow-software.org> <20060909101927.GA12986@1wt.eu>
In-Reply-To: <20060909101927.GA12986@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609091243.39220.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 September 2006 12:19, Willy Tarreau wrote:
> On Sat, Sep 09, 2006 at 12:15:25PM +0200, Ondrej Zary wrote:
> > On Saturday 09 September 2006 07:20, you wrote:
> > > On Fri, Sep 01, 2006 at 06:52:39PM +0200, Ondrej Zary wrote:
> > > > Hello,
> > > > my home router crashed after about a month. It does this sometimes
> > > > but this time I was able to capture the oops. Here is the result of
> > > > running ksymoops on it (took a photo of the screen and then manually
> > > > converted to plain-text). Does it look like a bug or something other?
> > >
> > > I have another problem with your oops. It looks like you used a
> > > /proc/ksyms from another running kernel. The symbol decoding does not
> > > match the code. For instance, in the disassembled code, you'll see that
> > > two functions are indicated for the same sequence of instructions
> > > (init_or_cleanup then ip_conntrack_protocol_register). And the
> > > difference does not look like a small offset, since neither of those
> > > functions seem to produce comparable code here.
> >
> > Sorry, it's the first time I tried to use ksymoops (was reporting only
> > 2.6 oopses before) and I probably screwed up. The problem is that there
> > is no /proc/ksyms (maybe because CONFIG_MODULES is disabled?):
> >
> > root@router:~# ls -l /proc/k*
> > -r-------- 1 root root 33558528 2006-09-09 11:58 /proc/kcore
> > -r-------- 1 root root        0 2006-09-07 14:32 /proc/kmsg
>
> Yes, that's very likely the reason.
>
> > I also didn't have the System.map file but found it in the tree on my
> > desktop machine (where that kernel was compiled) - haven't touched that
> > directory since the kernel compile so it should be correct one.
>
> This is strange, because as I said, the symbols do not seem to match the
> dumped data. If you still have your directory intact, could you please
> send me offlist (or put at some URL) your System.map and vmlinux (not
> bzImage) ? Please gzip them BTW.

Uhm, found the problem. The running kernel is not the last one I compiled. I 
added HTB to the kernel and recompiled it but the running version is without 
that. I have the old config file - so it might be possible to recreate the 
System.map - going to try that now.

>
> > > You should backup the /proc/ksyms from your currently running kernel,
> > > and reuse it to decode the next oops when it occurs. BTW, could you
> > > provide the full config file and tell us what version of GCC you're
> > > using ? Maybe we can try to find the same code sequence in a module and
> > > identify it without waiting for further oops.
> >
> > I've used GCC 2.95.3. Attached is dmesg and config file.
>
> Thanks, this can constitute a good starting point.
>
> Regards,
> Willy

-- 
Ondrej Zary
