Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWGQQjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWGQQjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWGQQj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:39:29 -0400
Received: from main.gmane.org ([80.91.229.2]:31386 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750999AbWGQQjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:39:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lexington Luthor <Lexington.Luthor@gmail.com>
Subject: Re: "Why Reuser 4 still is not in" doc
Date: Mon, 17 Jul 2006 17:38:11 +0100
Message-ID: <e9gedp$m22$1@sea.gmane.org>
References: <20060716161631.GA29437@httrack.com>  <20060716162831.GB22562@zeus.uziel.local>  <20060716165648.GB6643@thunk.org> <e9dsrg$jr1$1@sea.gmane.org>  <20060716174804.GA23114@thunk.org>  <20060716220115.a1891231.diegocg@gmail.com>  <e9ea1v$nc4$1@sea.gmane.org> <bda6d13a0607161428j187b737ft6f3925d9a3b2cc72@mail.gmail.com> <e9eg1v$5sf$1@sea.gmane.org> <Pine.LNX.4.61.0607171132430.11447@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bb-82-108-13-253.ukonline.co.uk
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
In-Reply-To: <Pine.LNX.4.61.0607171132430.11447@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Yes, it changes the semantics. Suddenly you can "cd linux-2.6.17.tar.bz2". 
> But what will stat() return? S_IFDIR? S_IFREG? S_IFANY? A .tar parser in 
> kernelspace is almost never the right thing. And then a cpio parser, 
> because that's what initramfs'es are made of. Not to forget .zip, because 
> that's omnipresent. Oh of course we'd also need bzip2 and gzip decoder. 
> BASE64 and UU anyone?

Is there any particular reason that the parsers need to be in 
kernel-space. The reiser4 plugins seem like an ideal counterpart to 
FUSE. Imagine being able to automatically FUSE-mount a tar file as a 
filesystem when you cd into it. stat() need not return S_IFDIR since 
everything is a directory anyway (only normal directories need S_IFDIR, 
just like currently). When you cd into a tar file, a FUSE-fs kicks in 
and provides access to the tar file as a normal filesystem inside it - 
from userspace.

> I wish you a lot of fun with users in LDAP or other exotic storage methods.
> By making Everything possible through echo, you are violating the unix 
> philosophy that one tool should do one thing (though echo does just that). 
> And in this case, echo would be chown, chmod, tar, bzip2 all at once. This 
> sounds familiar, I think I have seen this with explorer.exe (and its 
> uncountable DLLs), which lets you change everything within the same 
> window.

And why can meta-data not be accessed as files? To me, a lowly userspace 
developer, it seems even more inline with the UNIX way of things. bzip2 
can be in userspace while still providing data to kernel space via a 
FUSE-like interface.

Regards,
LL

