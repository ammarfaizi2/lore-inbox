Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVAUICS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVAUICS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVAUICS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:02:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47300 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261287AbVAUHzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:55:43 -0500
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<1106294155.26219.26.camel@2fwv946.in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Jan 2005 00:54:06 -0700
In-Reply-To: <1106294155.26219.26.camel@2fwv946.in.ibm.com>
Message-ID: <m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Hi Andrew,
> 
> Following patch is against 2.6.11-rc1-mm2. 
> 
> As mentioned by following note from Eric, crashdump code is currently
> broken.
> > 
> > The crashdump code is currently slightly broken.  I have attempted to
> > minimize the breakage so things can quick be made to work again.
> 
> We have started doing changes to make crashdump up and running again.
> Following are few identified items to be done.
> 
> 1. Reserve the backup region (640k) during kernel bootup. 

Why do we need a separate region for this?

It should be simple enough to take 640 out of the area kexec reserves
for the crash dump kernel.  That is what the previous code implemented.

> 2. Copy the data to backup region during crash.(moved to kexec user
> space code, patch posted in separate mail)

Thanks by and large it looks sane, it won't work yet the but it is
moving in the right direction.

> +++ linux-2.6.11-rc1-mm2-kexec-eric-root/include/linux/kexec.h 2005-01-20
> 13:55:33.000000000 +0530
> 
> @@ -79,7 +79,7 @@ struct kimage {
>  	unsigned long control_page;
>  
>  	/* Flags to indicate special processing */
> -	int type : 1;
> +	unsigned int type : 1;

That looks like a sane bug fix.  Having values of 0 and -1 is quite what
I was expecting...

Eric



