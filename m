Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTKQUtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTKQUtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:49:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:32679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261575AbTKQUta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:49:30 -0500
Date: Mon, 17 Nov 2003 12:49:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: sds@epoch.ncsc.mil, aviro@redhat.com, linux-kernel@vger.kernel.org,
       russell@coker.com.au
Subject: Re: [PATCH][RFC] Remove CLONE_FILES from init kernel thread
 creation
Message-Id: <20031117124954.6fa4e366.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0311171439590.2731-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0311171439590.2731-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> The patch below removes the CLONE_FILES flag from the kernel_thread() call
> which starts init.
> 
> This is to prevent other kernel threads from sharing file descriptors 
> opened by init (try 'lsof /dev/initctl' on a 2.6 system :-).
> 
> The reason this patch is being proposed is so that usermode helper apps
> launched via kernel threads (e.g. modprobe, hotplug) do not then inherit
> any such file descriptors.  This is not a problem in itself so far (other
> than being messy), but it is a problem for SELinux, which will otherwise
> need to grant access to /dev/initctl by modprobe and hotplug, a somewhat
> undesirable scenario.
> 
> As far as I can tell, there is no reason why init needs to be spawned with
> CLONE_FILES.  Please let me know if there are any objections to the
> change, which I would like to propose for 2.6.0+ as a cleanup.
> 

No, I can't think of a reason why we'd need CLONE_FILES in there.  I'll
toss it in and see what breaks.

I wonder why call_usermodehelper() uses CLONE_FILES...


