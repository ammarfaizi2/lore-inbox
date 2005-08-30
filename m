Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbVH3Mfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbVH3Mfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVH3Mfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:35:42 -0400
Received: from gromit.tds.de ([193.28.97.130]:35053 "EHLO gromit.tds.de")
	by vger.kernel.org with ESMTP id S1751425AbVH3Mfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:35:41 -0400
Date: Tue, 30 Aug 2005 14:35:30 +0200
From: Tim Weippert <weiti@security.tds.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Bongani Hlope <bonganilinux@mweb.co.za>, linux-kernel@vger.kernel.org
Subject: Re: Bad page state on AMD Opteron Dual System with kernel 2.6.13-rc6-git13
Message-ID: <20050830123529.GA4293@pbkg4>
Reply-To: Tim Weippert <weiti@security.tds.de>
References: <20050826165342.GA11796@pbkg4> <43110363.7020808@gentoo.org> <20050829052454.GA8172@pbkg4> <20050829102830.GA7604@pbkg4> <Pine.LNX.4.61.0508291401470.13709@goblin.wat.veritas.com> <20050829142318.GB7604@pbkg4> <20050830072759.GA4150@pbkg4> <Pine.LNX.4.61.0508301035410.6339@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0508301035410.6339@goblin.wat.veritas.com>
Organization: TDS Informationstechnologie AG
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:51:18AM +0100, Hugh Dickins wrote:
> On Tue, 30 Aug 2005, Tim Weippert wrote:
> > 
> > It seems the error is still there:
> > 
> > Aug 29 19:42:09 montdsnsu3 kernel: swap_free: Bad swap file entry
> > c800007fffffc02f
> > Aug 29 19:42:09 montdsnsu3 kernel: Kernel BUG at "mm/rmap.c":493
> > Aug 29 19:42:09 montdsnsu3 kernel: invalid operand: 0000 [3] SMP 
> > Aug 29 19:42:09 montdsnsu3 kernel: Pid: 26550, comm: sh Tainted: G    B
> 
> Thanks a lot for trying and reporting back.  That's bad news: I was
> willing to bet that the MSR would fix it.  Sorry for wasting your time.
> 
> Not quite conclusive though: I think (from the "[3]" above) that you've
> not rebooted since the earlier failures?  (Nor did I suggest you should.)
> 
> It's conceivable (though not very likely) that here you have the error
> reported on exit from a long-running "sh", running since before you made
> the MSR fix (the error I'm thinking of occurs when originally exec'ed,
> but may pass unnoticed while running).

Yes, this can possible, that the sh run before the changes were made.
but. The later problem suggest me that this not entirely fix the
problem.

> > Bongani Hlope suggest me to try this:
> > 
> > echo 0 > /proc/sys/kernel/randomize_va_space and look for 
> > http://bugzilla.kernel.org/show_bug.cgi?id=4851
> 
> Please do try that.  And if no luck with that, next time it's convenient
> for you to reboot, please write the MSR as early as you can to see if
> that makes any difference (probably not, but there's a chance).

Well, now i haven't any entries for the last 5 hours:

Aug 30 08:52:05 montdsnsu3 kernel: ping[6241] general protection
rip:2aaaaaaaed43 rsp:7fffff9bff00 error:0
Aug 30 08:54:04 montdsnsu3 kernel: grep[7422] general protection
rip:2aaaaaaaed43 rsp:7fffffdbf9b0 error:0
Aug 30 09:14:01 montdsnsu3 kernel: ping[22938] general protection
rip:2aaaaaaaed43 rsp:7fffff9c04b0 error:0

Maybe the randomize_va_space will fix or suppress it ... i will wait
until tomorrow and then i think i will reboot the machine and do both, 
the MSR write and the randomize_va_space settings.

Thanks for your help, 

    tim

-- 

Interpunktion und Orthographie dieser Email ist frei erfunden.
Eine Übereinstimmung mit aktuellen oder ehemaligen Regeln
wäre rein zufällig und ist nicht beabsichtigt.

Tim Weippert <weiti@topf-sicret.org>
http://www.topf-sicret.org/
