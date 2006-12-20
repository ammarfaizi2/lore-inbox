Return-Path: <linux-kernel-owner+w=401wt.eu-S1030198AbWLTVJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWLTVJX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWLTVJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:09:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:5008 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030198AbWLTVJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:09:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=WKtnDfr5xC5QgsF2LM6VYxSqEbtHbyj/SiicIGnk9BPcuiFdPkY7tQuLV8MQKhTcTOdU/j2CuAPekhCY7YXAwxaHEcxMF25p3XTQsahc+wsl+G088Yj0Vu6dG6YRxlFfg6ak5iYbDB0azU7Av81rHIjae2Yk21bYYRzz8yfbRno=
Date: Wed, 20 Dec 2006 21:07:36 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Andrew J. Barr" <andrew.james.barr@gmail.com>,
       linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       walt <w41ter@gmail.com>
Subject: Re: [-mm patch] ptrace: Fix EFL_OFFSET value according to i386 pda changes (was Re: BUG on 2.6.20-rc1 when using gdb)
Message-ID: <20061220210736.GC28900@slug>
References: <1166406918.17143.5.camel@r51.oakcourt.dyndns.org> <20061219164214.4bc92d77.akpm@osdl.org> <45891CD1.4050506@goop.org> <20061220183521.GA28900@slug> <45898D4E.1030507@goop.org> <20061220204226.GB28900@slug> <4589A2CD.2020108@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4589A2CD.2020108@goop.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 12:53:33PM -0800, Jeremy Fitzhardinge wrote:
> Frederik Deweerdt wrote:
> > It works too, thanks. BTW, I wondered if the "case GS:" in getreg() made
> > sense now?
> 
> Sorry, what do you mean?  It looks OK to me, but I'm not sure what
> you're referring to.
My bad, that's the code I'm referring to:

121 static unsigned long getreg(struct task_struct *child,
122         unsigned long regno)
[...]
126         switch (regno >> 2) {
127                 case GS:
128                         retval = child->thread.gs;
129                         break;

What seem weird to me is that putreg(GS) will end up putting 'value' in:
child->thread.esp0 - sizeof(struct pt_regs) + (GS - 1)*4
whereas getreg(GS) will return the value of child->thread.gs
I must miss something, but the symetry seemed odd to me.

Regards,
Frederik
> 
>     J
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
