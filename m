Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263636AbUDUTHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUDUTHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 15:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbUDUTHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 15:07:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:57994 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263636AbUDUTHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 15:07:23 -0400
Date: Wed, 21 Apr 2004 12:07:22 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, sds@epoch.ncsc.mil,
       jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: compute_creds fixup in -mm
Message-ID: <20040421120722.N22989@build.pdx.osdl.net>
References: <20040421010621.L22989@build.pdx.osdl.net> <4086AEFC.5010002@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4086AEFC.5010002@myrealbox.com>; from luto@myrealbox.com on Wed, Apr 21, 2004 at 10:27:24AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
>   void compute_creds(struct linux_binprm *bprm)
>   {
> -	security_bprm_apply_creds(bprm);
> +	task_lock(current);
> +
> +	security_bprm_apply_creds(bprm, must_not_trace_exec(current));
> +
> +	task_unlock(current);

unecessary extra lines.

> +static void selinux_bprm_apply_creds(struct linux_binprm *bprm, int unsafe)
> @@ -1782,14 +1780,13 @@
>   		/* Check for ptracing, and update the task SID if ok.
>   		   Otherwise, leave SID unchanged and kill. */
>   		task_lock(current);

oops ;-)

> -		if (current->ptrace & PT_PTRACED) {
> +		if (unsafe & (LSM_UNSAFE_PTRACE | LSM_UNSAFE_PTRACE_CAP)) {

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
