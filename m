Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWEYOxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWEYOxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 10:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWEYOxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 10:53:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964848AbWEYOxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 10:53:32 -0400
Date: Thu, 25 May 2006 07:52:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anssi Hannula <anssi@mandriva.org>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/11] input: new force feedback interface
Message-Id: <20060525075257.3f2963a9.akpm@osdl.org>
In-Reply-To: <4475C2F2.7090207@mandriva.org>
References: <20060515211229.521198000@gmail.com>
	<20060515211506.783939000@gmail.com>
	<20060517222007.2b606b1b.akpm@osdl.org>
	<44757246.9010300@mandriva.org>
	<20060525070017.16344c97.akpm@osdl.org>
	<4475C2F2.7090207@mandriva.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anssi Hannula <anssi@mandriva.org> wrote:
>
> > Generally we use file descriptors (and driver-specific state at
>  > file.f_private) to manage things like that.  But I'd imagine that we
>  > couldn't retain the existing semantics with any such scheme.
>  > 
>  > A pragmatic approach would be to put a big fat comment in there explaining
>  > how it all works and leave it at that.
> 
>  As I don't see this could break any existing applications, I would very
>  much like to change the behaviour so that the effects are file
>  descriptor specific.

ooh, that's always risky - we just don't know what people are doing out
there.  They do the damnedest things.

Is it possible to implement the new behaviour while retaining the old
behaviour as well?  And to detect when an app is using the old behaviour
and to drop a printk("stop doing this")?  So we can kill the old behaviour
in a year or so?

> What should I use to differentiate the descriptors?
>  Can I just compare the "struct file*"? (it seems to work well, I just
>  modified the code so)

Depends what you're trying to do.  Different threads in the same process
can share the same file*'s.

