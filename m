Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSKJOEu>; Sun, 10 Nov 2002 09:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264874AbSKJOEu>; Sun, 10 Nov 2002 09:04:50 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:23712 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264878AbSKJOEt>; Sun, 10 Nov 2002 09:04:49 -0500
Subject: Re: [lkcd-devel] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <m1bs4ycer2.fsf@frodo.biederman.org>
References: <Pine.LNX.4.33L2.0211091533260.10722-100000@dragon.pdx.osdl.net> 
	<m1bs4ycer2.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Nov 2002 14:35:13 +0000
Message-Id: <1036938913.1009.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-10 at 02:58, Eric W. Biederman wrote:
> > What I'm trying to say is that I think the new kernel must
> > already be loaded when the panic happens.
> > Is that what you describe later (below)?
> 
> Yes that was my meaning.   The new kernel must be preloaded.
> And only started on panic.

Another question from the point of view of unifying things. What is
wrong with

	insmod kexec
		creates /dev/kexec (or kexecfs is you are Al Viro)
		hooks the reboot and panic final notifiers
	user copies file to /dev/kexec (which stuffs it into ram)

	reboot
		kexec module handler jumps to the first page of the
		kexec data in a defined state assuming its PIC


At which point we have clearly reduced kexec/oops reporter/lkcd/netdump 
to a single common tiny interface.

