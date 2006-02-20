Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWBTKLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWBTKLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWBTKLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:11:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964829AbWBTKLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:11:33 -0500
Date: Mon, 20 Feb 2006 02:09:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, B.Steinbrink@gmx.de,
       viro@ftp.linux.org.uk
Subject: Re: + daemonize-detach-from-current-namespace.patch added to -mm
 tree
Message-Id: <20060220020943.1d9eac25.akpm@osdl.org>
In-Reply-To: <m1ek1ymmec.fsf@ebiederm.dsl.xmission.com>
References: <200602200438.k1K4ct5n013388@shell0.pdx.osdl.net>
	<1140425218.2979.14.camel@laptopd505.fenrus.org>
	<m1ek1ymmec.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> I am beginning to suspect that we will want to fix kernel_thread so it
>  creates copies of the init_task rather than copies of whatever random
>  user space process we happen to be a member of at the time.  With an
>  enhanced kernel_thread this problem could more easily avoided, as
>  we add additional namespaces to the kernel.

You wouldn't believe the problems we had with kernel_thread followed by
call_usermodehelper() due to inheritance of random stuff from the userspace
parent.

A suitable solution is to stop using kernel_thread(), migrate to the
kthread API - that way the threads are parented by keventd which is a known
and good environment.

