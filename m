Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUCVQCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUCVQCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:02:32 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:12169 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262070AbUCVQC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:02:26 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 22 Mar 2004 08:02:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
In-Reply-To: <m1ekrldt6o.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.44.0403220744150.1788-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Mar 2004, Eric W. Biederman wrote:

> Davide Libenzi <davidel@xmailserver.org> writes:
> 
> > There has been a misunderstanding. I thought you were talking about a 
> > userspace solution ala fl-cow. Of course if you are inside the kernel you 
> > can catch both explicit writes and page syncs.
> 
> Right.  Although there is nothing prevent the copy to be in user space
> even with the trigger hooks down in the write path.

How do you insert yourself before the first page fault to do the COW, from 
userspace (open+mmap)? You can obviously hook mmap(2) and if a PROT_WRITE 
is requested, you COW from there. But then you have an whole bunch of new 
problems (again, when done from userspace) because, just to begin with, 
you need a stateful interception layer (while fl-cow for example is stateless).
In my modest usage scenario for my fl-cow shell (emacs+patch+diff+gcc) 
I've found that when something opens in RDWR, it really writes the file at 
some point during the opened session. So moving the COW down in the write 
path helps little or nothing. There may be as well other use cases where 
applications do frequently open in RDWR even w/out ever touching the file.



- Davide


