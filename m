Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVIWRMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVIWRMO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVIWRMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:12:13 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:44651 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750815AbVIWRMM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:12:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e+XdmVwWBMYjAxdE74FPc3nUgRJDC13KRvF8vvSwmOMPhOPKjipC090CbAdRQz5dX4TuQS0OLD/LRZdidvA05QH3fX4w1ZnW+R5rn3EtmMNv7KqoAJ0gC+CjTfB/AWIA+G7szsLNcOKgRn/tJSYRhGzHo+x0R4s2g9tqyFJSnTI=
Message-ID: <29495f1d050923101228384a34@mail.gmail.com>
Date: Fri, 23 Sep 2005 10:12:11 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: tty update speed regression (was: 2.6.14-rc2-mm1)
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050923000815.GB2973@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050921222839.76c53ba1.akpm@osdl.org>
	 <20050922195029.GA6426@mipter.zuzino.mipt.ru>
	 <20050922214926.GA6524@mipter.zuzino.mipt.ru>
	 <20050923000815.GB2973@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/05, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> On 23.09.2005 [01:49:26 +0400], Alexey Dobriyan wrote:
> > On Thu, Sep 22, 2005 at 11:50:29PM +0400, Alexey Dobriyan wrote:
> > > I see regression in tty update speed with ADOM (ncurses based
> > > roguelike) [1].
> > >
> > > Messages at the top ("goblin hits you") are printed slowly. An eye can
> > > notice letter after letter printing.
> > >
> > > 2.6.14-rc2 is OK.
> > >
> > > I'll try to revert tty-layer-buffering-revamp*.patch pieces and see if
> > > it'll change something.
> > >
> > > [1] http://adom.de/adom/download/linux/adom-111-elf.tar.gz (binary only)
> >
> > Scratch TTY revamp, the sucker is
> > fix-sys_poll-large-timeout-handling.patch
> >
> > HZ=250 here.
>
> Alexey,
>
> Thanks for the report. I will take a look on my Thinkpad with HZ=250
> under -mm2. I have some ideas for debugging it if I see the same
> problem.

I did not see any tty refresh problems on my TP with HZ=250 under
2.6.14-rc2-mm1 (excuse the typo in my previous response) under the
adom binary you sent me. I even played two games just to make sure ;)

Is there any chance you can do an strace of the process while it is
slow to redraw your screen? Just to verify how poll() is being called
[if my patch is the problem, then poll() must be being used somewhat
differently than I expected -- e.g. a dependency on the broken
behavior]. The only thing I can think of right now is that I made
timeout_jiffies unsigned, when schedule_timeout() will treat it as
signed, but I'm not sure if that is the problem.

We may want to contact the adom author eventually to figure out how
poll() is being used in the Linux port, if strace is unable to help
further.

Thanks,
Nish
