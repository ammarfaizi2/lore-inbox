Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTKKNZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 08:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTKKNZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 08:25:12 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:48588 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261788AbTKKNZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 08:25:06 -0500
Subject: Re: [autofs] "simultaneous" mounts causing weird behavior
From: Ian Kent <raven@themaw.net>
To: Matthew Mitchell <matthew@geodev.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1068483422.2640.458.camel@aluminum>
References: <Pine.LNX.4.33.0311061108300.32640-100000@wombat.indigo.net.au>
	 <1068483422.2640.458.camel@aluminum>
Content-Type: text/plain
Organization: 
Message-Id: <1068557622.3147.45.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Nov 2003 21:33:43 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-11 at 00:57, Matthew Mitchell wrote:

> > You should be using the latest autofs4 kernel module with this. It is
> > available form the same place you got the beta autofs-4.
> 
> OK.  Looks like a big change to the kernel setup (from a quick browse of
> the patch).  In the interest of isolating the change to userspace, can
> you point me to a version of autofs4 that works with the stock 2.4.20
> kernel module?  I'd be happy to forward-port anything that works and
> test it again with the newer code.  (I can test the new stuff pretty
> easily on one machine but I don't want to undertake the week-long
> process of updating the kernel on the whole cluster just for this
> problem.)
> 

What is the question here. autofs is a kernel automounter. The autofs4
kernel module is as much a part of the package as the daemon. There is
no userspace version of the kernel module. I can't see how there can be.

Using the module distributed with 2.4 kernels is fine if you don't want
browsable mount points and that's it.

<rant>

I must also add that you don't need to change the kernel source tree at
all to use my updated kernel module. This was one of the reasons I
constructed the module build kit (available on kernel.org in the same
directory as the autofs v4 package). Further more, the changes I have
made are exclusively to the autofs4 module, as should be the case for
any filesystem module.

The other reason I put the kit together was that when I took over
maintenance of autofs v4, the previous maintainer, although happy to
hand over the maintenance of the daemon, was less than happy for me to
maintain the kernel module. So I will, as time passes, try to get my
changes into the kernel although I haven't made any progress there yet.

</rant>

You need to read the doco in the kit to use it. Briefly, you need the
kernel source tree corresponding to the running kernel and matching
kernel config file. In Makefile.conf set the macro variables as
instructed and 'make' then 'make install' (install must be done as
root). This will build the module, make a copy of the kernels' module
and place the updated module in the right place. Subsequent 'make
install' will not overwrite the backup if it already exists. 'make
uninstall' will reinstate the original kernel module.

I have tried to cater for people who are reluctant to patch and build
kernels with the kit.  

What else can I do?

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

