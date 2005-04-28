Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVD1Nrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVD1Nrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 09:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVD1Nrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 09:47:48 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:57174 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262133AbVD1Nrp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 09:47:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fFeRxdi29RnfRGhjbEzwOh3uUTVhqn4swoSp8rLBb1LiP7NSJK6iDEY4AB8em7AdXrIe6W/7YQdq7fKaqf5d1Rum0a3HudHUWNELCTSnVKKqZ4XdOWeIQLWiGFbJhXyQSQP11BfiRH4ZP+3erYw29j63PYA+uzCQy/i8vpT3xw8=
Message-ID: <a4e6962a050428064774e88f4a@mail.gmail.com>
Date: Thu, 28 Apr 2005 08:47:44 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] private mounts
Cc: Pavel Machek <pavel@ucw.cz>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20050426140715.GA10833@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1DPnOn-0000T0-00@localhost> <E1DPo3I-0000V0-00@localhost>
	 <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk>
	 <E1DPoCg-0000W0-00@localhost>
	 <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
	 <20050424213822.GB9304@mail.shareable.org>
	 <20050425152049.GB2508@elf.ucw.cz>
	 <20050425190734.GB28294@mail.shareable.org>
	 <20050426092924.GA4175@elf.ucw.cz>
	 <20050426140715.GA10833@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Jamie Lokier <jamie@shareable.org> wrote:
> 
> It's called /proc/NNN/root.
> 
> So no new system calls are needed.  A daemon to hand out per-user
> namespaces (or any other policy) can be written using existing
> kernels, and those namespaces can be joined using chroot.
> 
> That's the theory anyway.  It's always possible I misread the code (as
> I don't use namespaces and don't have tools handy to try them).
> 

Should have checked myself before posting my previous reply -- but
this doesn't seem to work.  /proc/NNN/root is represented as a
symlink, but when you CLONE_NS and then try to look at another one of
your process' /proc/NNN/root the link doesn't seem to have a target
and you get permission denied on all accesses.  I haven't looked at
the underlying procfs code, but adapting procfs for this sort of
purpose feels wrong.

          -eric
