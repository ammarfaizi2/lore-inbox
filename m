Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVJKPcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVJKPcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 11:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVJKPcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 11:32:24 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:28267 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751387AbVJKPcX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 11:32:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RtoBGiivvC87X98tWrV9fS4FvVkc4PgfDU6RjGPlRNzMfT1qavNyrnfSW38AUysUSSJ47Z38WXh8T3aXj/r2Lfiv86ClV4VyVdG8xhij3Q3OBinTo16EU/NAcG7E5OJzXvfYYqWoWBJtmudStNqBjdEzyo4yygFByg4EfX0hiQ0=
Message-ID: <35fb2e590510110832m39ef179eob07fb47f6f22c72f@mail.gmail.com>
Date: Tue, 11 Oct 2005 16:32:22 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Regarding - unresolved symbol
Cc: vinay hegde <thisismevinay@yahoo.co.in>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0510111104390.32115@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051011135944.22612.qmail@web8402.mail.in.yahoo.com>
	 <Pine.LNX.4.61.0510111104390.32115@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:

> On Tue, 11 Oct 2005, vinay hegde wrote:

> > [I am able to fix this problem by simply using the
> > 'sys_mknod()' call in my module, but I really would
> > like to know why the above piece of code can not
> > work!]

> Even sys_mknod() should not work from a module; Who's
> context did you steal to create that device-file? What
> happens next to that poor sucker? Who's data-space
> did you corrupt for the file-name string? I note that,
> from the names, it's likely that you intend to do this
> dastardly deed from a timer-queue!!!

Yummy.

> File operations require a process context. The kernel doesn't
> have one. All file operations should (read must) be done
> from user space. The kernel is designed to do things
> on behalf of user-space callers. Executing sys_* from
> a module will result in somebody saying; "See, you are
> wrong... It works fine!". Later on mysterious errors
> occur which are un-trackable.

The fix is to call out to userland to get the device node cerated for
you - either allow udev/devfs to do this for you, use
call_usermode_helper to do it, send a message up to userland via
NETLINK or whatever. There's more than one way to do it.

Jon.
