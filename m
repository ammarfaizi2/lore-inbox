Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUELVjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUELVjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUELVjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:39:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17326 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261563AbUELViX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:38:23 -0400
Date: Wed, 12 May 2004 23:12:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512211255.GA20800@elte.hu>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com> <20040512200305.GA16078@elte.hu> <Pine.LNX.4.58.0405121400360.11950@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405121400360.11950@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Davide Libenzi <davidel@xmailserver.org> wrote:

> int foo(int i) {
> 
> 
>         return i * 1000 / 1000;
> }

try unsigned and you'll see:

        pushl   %ebp
        movl    %esp, %ebp
        movl    8(%ebp), %edx
        movl    %edx, %eax
        sall    $2, %eax
        addl    %edx, %eax
        leal    0(,%eax,4), %edx
        addl    %edx, %eax
        leal    0(,%eax,4), %edx
        addl    %edx, %eax
        leal    0(,%eax,8), %edx
        movl    $274877907, %eax
        mull    %edx
        movl    %edx, %eax
        shrl    $6, %eax
        leave
        ret

    Ingo
