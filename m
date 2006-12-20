Return-Path: <linux-kernel-owner+w=401wt.eu-S1030283AbWLTTCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWLTTCW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWLTTCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:02:21 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:35233 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030283AbWLTTCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:02:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:content-transfer-encoding:date:message-id:mime-version:x-mailer;
        b=PWxZyrbQFvmIPb43hVtxVGwT1pLnfvl/xnD8ztmSsxjOPZlYSbH3g9qQ3wmTiSXUF7vyW0NEsdu+RnHF4qBvvKMM0rnTHiNm5a37BRFiSNC8BNLBE0MO1yP1qCG8DPe3XmYneIcVsTvjWGz9AQCmGpIXNN6M+eReptxq3ZwCkv8=
Subject: Re: [-mm patch] ptrace: Fix EFL_OFFSET value according to i386 pda
	changes (was Re: BUG on 2.6.20-rc1 when using gdb)
From: "Andrew J. Barr" <andrew.james.barr@gmail.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       walt <w41ter@gmail.com>
In-Reply-To: <20061220183521.GA28900@slug>
References: <1166406918.17143.5.camel@r51.oakcourt.dyndns.org>
	 <20061219164214.4bc92d77.akpm@osdl.org> <45891CD1.4050506@goop.org>
	 <20061220183521.GA28900@slug>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Dec 2006 14:02:15 -0500
Message-Id: <1166641335.4017.0.camel@r51.oakcourt.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 18:35 +0000, Frederik Deweerdt wrote:
> On Wed, Dec 20, 2006 at 03:21:53AM -0800, Jeremy Fitzhardinge wrote:
> > "walt" <w41ter@gmail.com> reported a similar problem which he bisected
> > down to the PDA changeset which touches ptrace
> > (66e10a44d724f1464b5e8b5a3eae1e2cbbc2cca6).  I haven't managed to repo
> > the problem, but I guess there's something nasty going on in ptrace -
> > maybe its screwing up eflags on the stack or something.  Need to
> > double-check all the conversions from kernel<->usermode registers.  Hm,
> > wonder if its fixed with the %gs->%fs conversion patch applied?
> > 
> Hi Jeremy,
> 
> Same problems here with 2.6.20-rc1-mm1 (ie with the %gs->%fs patch).
> It seems to me that the problem comes from the EFL_OFFSET no longer
> beeing accurate.
> The following patch fixes the problem for me.

Me too. Thanks.

Andrew

> Regards,
> Frederik
> 
> Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>
> 
> diff --git a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
> index 7f7d830..00d8a5a 100644
> --- a/arch/i386/kernel/ptrace.c
> +++ b/arch/i386/kernel/ptrace.c
> @@ -45,7 +45,7 @@
>  /*
>   * Offset of eflags on child stack..
>   */
> -#define EFL_OFFSET ((EFL-2)*4-sizeof(struct pt_regs))
> +#define EFL_OFFSET ((EFL-1)*4-sizeof(struct pt_regs))
>  
>  static inline struct pt_regs *get_child_regs(struct task_struct *task)
>  {
