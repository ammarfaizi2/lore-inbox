Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWDVAFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWDVAFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDVAFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:05:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:16314 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750774AbWDVAFN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:05:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m8viRGWQWhFofic+krQ3w2x/vp8WRF4o83pjpy6ucMAop7Ee4GIyB900ODF3bhIi2pfIcDxxndVuZf5XbTEFu4TCJrtYsdekIi1fxwaGsd3cydD+5Bf1/CESCQ9eUaY0oujs6XkYOiM+2vXOYquZ3AbKzblnkCUz9b3XdV8CRvM=
Message-ID: <5a4c581d0604211705k6fa253at658fe8c321f1bc13@mail.gmail.com>
Date: Sat, 22 Apr 2006 02:05:12 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: nick@linicks.net
Subject: Re: iptables is complaining with bogus unknown error 18446744073709551615
Cc: "Maurice Volaski" <mvolaski@aecom.yu.edu>,
       "Harald Welte" <laforge@netfilter.org>, linux-kernel@vger.kernel.org,
       netfilter@lists.netfilter.org
In-Reply-To: <7c3341450604211126g7e431307q251f9ea49c0ebf91@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a06230910c06e2510acfa@129.98.90.227> <20060421111530.GE5286@rama>
	 <a06230913c06e96f75f32@129.98.90.227>
	 <7c3341450604211126g7e431307q251f9ea49c0ebf91@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/06, Nick Warne <nick.warne@gmail.com> wrote:
> I also ask the same - this 'config' problem/option has been posted on
> the list previously, I believe.
>
> I was about to update my gateway box to 2.6.16.9 this weekend, and I
> do not build modules on that - so what do I need to do to ensure this
> xt_tcpudp is built in?
>
> Is '> make oldconfig' enough to pull this in?
>
> Nick

Hmm, let's see:

[asuardi@donkey src]$ grep tcpudp linux-2.6.17-rc1-git4/net/netfilter/Makefile
obj-$(CONFIG_NETFILTER_XTABLES) += x_tables.o xt_tcpudp.o

OK, I recall configuring this a while ago when still using FC3,
 as I was bitten too by iptables complaining with the bogus
 error code which I eventually tracked back to the XTABLES
 stuff (no - make oldconfig didn't do it for me and I had to go
 through the config options by hand enabling what I thought
 was useful). That was since...

[asuardi@donkey src]$ grep -i XTABLES /fc3/usr/src/.config-2.6.1[0-7]*
/fc3/usr/src/.config-2.6.15-git10:CONFIG_NETFILTER_XTABLES=m
/fc3/usr/src/.config-2.6.15-git11:CONFIG_NETFILTER_XTABLES=m
/fc3/usr/src/.config-2.6.16-rc1-git4:CONFIG_NETFILTER_XTABLES=m
/fc3/usr/src/.config-2.6.16-rc2-git7:CONFIG_NETFILTER_XTABLES=m

And without any special tricks, my bittorrent box (which also
 has peerguardian running) loads xt_tcpudp automatically,
 as it should be...

[asuardi@donkey src]$ lsmod
Module                  Size  Used by
xt_tcpudp               3200  0
iptable_filter          3072  1
ip_tables              13960  1 iptable_filter
x_tables               14468  2 xt_tcpudp,ip_tables
sd_mod                 18000  2
usb_storage            35588  1
scsi_mod              101064  2 sd_mod,usb_storage
floppy                 58052  0
ehci_hcd               30984  0
uhci_hcd               22792  0
psmouse                38280  0
parport_pc             28644  0
parport                26496  1 parport_pc
8139too                25920  0
8139cp                 21824  0

> On 21/04/06, Maurice Volaski <mvolaski@aecom.yu.edu> wrote:
> > Thank you for your reply.
> >
> > >Hi Maurice.
> > >
> > >Didn't you report this bug already to bugzilla.netfilter.org (and maybe
> > >eben to the bugme.osdl.org)?  Reporting a bug in three distinct places,
> > >even though it has been replied to at one place is not really going to
> > >use developer resources efficiently, don't you think?
> >
> > Sorry, to post it multiple times. Actually, two places netfilter and
> > then kernel bugzilla. I made the second report after it appeared
> > there'd would be no feedback to the first one and another kernel
> > revision had been issued with the problem still evident. (The first
> > feedback on the netfilter report crossed in the mail with the kernel
> > report.)
> >
> > >However, your problem seems to be something different.  I suspect that
> > >all rules with '-p tcp' or '-p udp' don't work, whereas others do.  You
> > >seem to be missing the xt_tcpudp.ko module, which implements that
> > >feature in 2.6.17-rcX kernels.
> >
> > Yep, that's it. How could one know that there is such a module called
> > xt_tcpudp.ko, especially since there is no corresponding config
> > option? Wouldn't up-to-date and complete documentation explain how to
> > set up the kernel config and indicate which modules should be loaded?
> >
> > On the other hand, shouldn't this module be loading automatically?

--alessandro

 "Dreamer ? Each one of us is a dreamer. We just push it down deep because
   we are repeatedly told that we are not allowed to dream in real life"
     (Reinhold Ziegler)
