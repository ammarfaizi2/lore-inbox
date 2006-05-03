Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWECOkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWECOkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbWECOkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:40:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:49753 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965204AbWECOkV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:40:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PUEiBwAb0WkZjvYLHPkw/8YKZglrlas06YO6MkCtl2yC8NX2o+tAOqolYlIfL8OqedCx6map2m1zNHsCGTNSHQL6WIypCSo649H7W+stoONFVIQzK9URwCgDAiey5MYaYYP3NhLo7uUEb5JbP+/AKkyNzrChiPh4cpuXPgKl5u8=
Message-ID: <9e4733910605030740s6f394676g66377f2a48cd4209@mail.gmail.com>
Date: Wed, 3 May 2006 10:40:19 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 11/14] Reworked patch for labels on user space messages
Cc: linux-kernel@vger.kernel.org, "Stephen Smalley" <sds@tycho.nsa.gov>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <20060503142802.GD27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1FaVfH-000531-LX@ZenIV.linux.org.uk>
	 <9e4733910605030711p2acab747g8f2ea7fdbb95f3c4@mail.gmail.com>
	 <20060503142802.GD27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Wed, May 03, 2006 at 10:11:52AM -0400, Jon Smirl wrote:
> > Something seems to be wrong in selinux_get_task_sid. I am getting
> > thousands of these and can't boot the kernel.
>
> It's actually in security/selinux/hooks.c::selinux_disable() and gets
> triggered if you have selinux enabled and explicitly disable afterwards.
> Stephen Smalley had done a fix yesterday, basically adding
>         selinux_enabled = 0;
> after
>         selinux_disabled = 1;
> in there.  selinux_get_task_sid() happens to step on that in visible way
> and nobody had caught that while this stuff was sitting in -mm ;-/
>
> The only question I have about that patch: what would happen if we do not
> have CONFIG_SECURITY_SELINUX_BOOTPARAM?  In that case selinux_enabled is
> defined to 1, so...

I have these config options set:

CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1

SELinux needs to be built in or FC5 won't run.

--
Jon Smirl
jonsmirl@gmail.com
