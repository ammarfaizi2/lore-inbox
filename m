Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVA0DI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVA0DI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVAZXM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:12:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46808 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262438AbVAZRXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:23:45 -0500
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<1106294155.26219.26.camel@2fwv946.in.ibm.com>
	<m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	<1106305073.26219.46.camel@2fwv946.in.ibm.com>
	<m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
	<1106475280.26219.125.camel@2fwv946.in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Jan 2005 10:21:56 -0700
In-Reply-To: <1106475280.26219.125.camel@2fwv946.in.ibm.com>
Message-ID: <m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Right now I am very frustrated with reviewing any of the crashdump
patches.  When I make comments usually things change just enough that
what I said is addressed but things are addressed very much at
a surface level.  Which means that if I think any kind of substantial
change is needed the only way I seem to be able to communicate
that is by actually implementing it myself.

Code that works today is great it does manages the job of requirements
capture.   But just throwing code together when you are dealing
with fundamental interface boundaries is not a good way to build
a sustainable design.  And with the crashdump code I want an
interface that is at least as simple and as stable as the syscall
interface.

At the very least if a patch is just a snapshot of your development
process up for comment and you are going to continue on making
headway please say as much.  If I know the code is quite possibly
going to change in some pretty fundamental ways I can stop worrying
about it.  This patch is certainly nothing I would want for more
than a couple of day hack, in my personal development tree.

I will try once again...

There is evil intermingling and false dependency sharing between
the dying kernel and the crash capture kernel in this patch, and
virtually all of the code is unnecessary.  I have already addressed
why.

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Fri, 2005-01-21 at 16:43, Eric W. Biederman wrote:
> > On deeper review your patch as it stands is incomplete.  In particular
> > you don't provide a way to either hardcode or dynamically set
> > the area you are attempt to reserve to hold the backup region.
> 
> Well. Here is the new patch. This one steals the 640k from top of memory
> region reserved for crash kernel. 
> 
> A new command line parameter (crashbackup=) has been introduced for
> crash dump kernels. This parameter specifies the location of backup
> region from where to retrieve the backup data.

What is wrong with user space doing all of the extra space
reservation?

Could you send this fairly obvious kexec fix, as a separate patch? 

> diff -puN include/linux/kexec.h~crashdump-x86-reserve-640k-memory
> include/linux/kexec.h
> 
> --- linux-2.6.11-rc1/include/linux/kexec.h~crashdump-x86-reserve-640k-memory
> 2005-01-22 14:16:27.000000000 +0530
> 
> +++ linux-2.6.11-rc1-root/include/linux/kexec.h 2005-01-22 14:16:27.000000000
> +0530
> 
> @@ -79,7 +79,7 @@ struct kimage {
>  	unsigned long control_page;
>  
>  	/* Flags to indicate special processing */
> -	int type : 1;
> +	unsigned int type : 1;
>  #define KEXEC_TYPE_DEFAULT 0
>  #define KEXEC_TYPE_CRASH   1
>  };

Eric
