Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbSJCXAj>; Thu, 3 Oct 2002 19:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJCXAj>; Thu, 3 Oct 2002 19:00:39 -0400
Received: from gw.openss7.com ([142.179.199.224]:23051 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261366AbSJCXAh>;
	Thu, 3 Oct 2002 19:00:37 -0400
Date: Thu, 3 Oct 2002 17:06:08 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021003170608.A30759@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021003153943.E22418@openss7.org> <1033682560.28850.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033682560.28850.32.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 03, 2002 at 11:02:40PM +0100
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Would it be possible to put a secondary call table behind
the call gate wrappered in sys_ni_syscall that a module
could register against.  Is it merely the fact that the
call gate table itself must be static?  A secondary table
and a mechanism to register against the secondary table with
kernel locks taken behind the call gate would be trivial,
I think.

Does that sound like the best way to go about it?

--brian

On Thu, 03 Oct 2002, Alan Cox wrote:

> On Thu, 2002-10-03 at 22:39, Brian F. G. Bidulock wrote:
> > I see that RH, in their infinite wisdom, have seen fit to remove
> > the export of sys_call_table in 8.0 kernels breaking any loadable
> > modules that wish to implement non-implemented system calls such
> > as LiS's or iBCS implementation of putmsg/getmsg.
> 
> Overwriting syscall table entries is not safe. Its not safe because
> there is no locking mechanism, and its not safe because of the pentium
> III errata.
> 
> > Until now, loadable modules have been able to just overwrite
> > the non implemented point in the sys_call_table when they load
> > and putting it back when they unload.  There is no mechanism
> > for registering system calls.
> 
> Not actually safely implementable. The right way to do this is a
> relevant 2.5 question. In general however you shouldnt need to register
> syscalls because the upper layer interfaces already exist (the LiS stuff
> is an example otherwise I grant). 
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
