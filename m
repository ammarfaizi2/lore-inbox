Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTLGNmH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 08:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTLGNmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 08:42:07 -0500
Received: from holomorphy.com ([199.26.172.102]:55512 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264455AbTLGNmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 08:42:04 -0500
Date: Sun, 7 Dec 2003 05:42:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Riesen <fork0@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] FIx 'noexec' behavior
Message-ID: <20031207134200.GY8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Riesen <fork0@users.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
References: <20031207133906.GA1140@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207133906.GA1140@steel.home>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 02:39:06PM +0100, Alex Riesen wrote:
> I had to put a check for 'file' (as Ulrich suggested).
> Otherwise it deadlocks again.
> Is it possible for ->f_vfsmnt to be NULL at all? Should it be tested?
> diff -Nru a/mm/mmap.c b/mm/mmap.c
> --- a/mm/mmap.c Sun Dec  7 14:37:33 2003
> +++ b/mm/mmap.c Sun Dec  7 14:37:33 2003
> @@ -478,7 +478,7 @@
>         if (file && (!file->f_op || !file->f_op->mmap))
>                 return -ENODEV;
>  
> -       if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
> +       if ((prot & PROT_EXEC) && file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
>                 return -EPERM;
>  
>         if (!len)

This does not resemble the code I was looking at from current bk.


-- wli
