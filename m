Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbTH2Q2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbTH2Q2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:28:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:13456 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261452AbTH2Q1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:27:55 -0400
Message-Id: <200308291627.h7TGRoX02912@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, cliffw@osdl.org
Subject: Re: 2.6.0-test4-mm3 
In-Reply-To: Message from Andrew Morton <akpm@osdl.org> 
   of "Fri, 29 Aug 2003 08:35:40 PDT." <20030829083540.58c9dd47.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Aug 2003 09:27:50 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Boszormenyi Zoltan <zboszor@freemail.hu> wrote:
> >
> > I tried to "make modules_install" on the compiled tree.
> > It says:
> > 
> > # make modules_install
> > Install a current version of module-init-tools
> > See http://www.codemonkey.org.uk/post-halloween-2.5.txt
> > make: *** [_modinst_] Error 1
> > 
> > But I have installed it! It's called modutils-2.4.25-8
> > (was -5 previously) from RH rawhide, it works on older
> > (2.6.0-test4-mm1) kernels.
> > This modutils is united with module-init-tools-0.9.12,
> > it reports version 2.4.25 but detects newer kernels and uses
> > the new module interface.
> 
> Tricky.
> 
> It's wrong of the Red Hat package to misidentify itself in this manner.
> 
> It would sort-of make sense for `depmod -V' to autodetect the kernel
> version and print either "modutils" or "module-init-utils".  But that's not
> accurate either: a `make modules_install' would fail when performed under a
> 2.4 kernel.
> 
> So yes, I think that your patch to RH modutils+module-init-tools is the best
> approach: after all, it tells the truth.
> 
> Meanwhile, I'll alter Valdis's patch so that it warns, but does not fail
> the make.
> 

This also breaks STP. We installed module-init-tools using the 'moveold' 
method,
so we can still run 2.4.
Our depmod is in /usr/local/sbin. 
Using /sbin/depmod hoses us. Using PATH works for us.

[root@stp1-002 linux]# depmod -V
module-init-tools 0.9.12

[root@stp1-002 linux]# /sbin/depmod -V
depmod version 2.4.22

[root@stp1-002 linux]# /usr/local/sbin/depmod -V
module-init-tools 0.9.12

Please send patch, we'll get some tests moving.
cliffw

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


