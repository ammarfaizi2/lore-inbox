Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbUJZUYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbUJZUYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUJZUXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:23:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:29133 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261403AbUJZUU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:20:57 -0400
Date: Tue, 26 Oct 2004 13:18:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: ray-lk@madrabbit.org, sct@redhat.com, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [PATCH 2/3] ext3 reservation allow turn off
 for specifed file
Message-Id: <20041026131842.45b99834.akpm@osdl.org>
In-Reply-To: <1098809607.8919.7466.camel@w-ming2.beaverton.ibm.com>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	<1097856114.4591.28.camel@localhost.localdomain>
	<1097858401.1968.148.camel@sisko.scot.redhat.com>
	<1097872144.4591.54.camel@localhost.localdomain>
	<1097878826.1968.162.camel@sisko.scot.redhat.com>
	<109787 
	<1098147705.8803.1084.camel@w-ming2.beaverton.ibm.com>
	<1098294941.18850.4.camel@orca.madrabbit.org>
	<1098736389.9692.7243.camel@w-ming2.beaverton.ibm.com>
	<1098745548.9754.7427.camel@w-ming2.beaverton.ibm.com>
	<20041025164516.1f02bb9f.akpm@osdl.org>
	<1098809607.8919.7466.camel@w-ming2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> > I wonder how important this optimisation really is?  I bet no applications
>  > are using posix_fadvise(POSIX_FADV_RANDOM) anyway.
>  > 
>  I don't know if there is application using the POSIX_FADV_RANDOM. No? If
>  this is the truth, I think we don't need this optimization at present.
>  Logically reservation does not benefit seeky random write, but there is
>  no benchmark showing performance issue so far. We have already provided
>  ways for applications turn off reservation through the existing ioctl
>  for specified file and -o noreservation mount option for the whole
>  filesystem.

Well we definitely don't want to be encouraging application developers to be
adding ext3-specific ioctls.  So we need to work out if any applications
can get significant benefit from manually disabling reservations and if
so, wire up fadvise() into filesystems and do it that way.

Do you know if disabling reservations helps any workloads?
