Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUIGSRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUIGSRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUIGSRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:17:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:33189 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268336AbUIGSPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:15:12 -0400
Subject: Re: [PATCH] Add prctl to modify current->comm
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bastian@suse.de
In-Reply-To: <20040907142753.GA20981@wotan.suse.de>
References: <20040907142753.GA20981@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094577168.9599.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 18:12:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 15:27, Andi Kleen wrote:
> I considered the potential security issues of a program obscuring
> itself with this interface, but I don't think it matters much
> because a program can already obscure itself when the admin uses
> ps instead of top. In case of a KDE desktop calling everything
> kdeinit is much more obfuscation than the alternative.

Actually its a lot simpler than that.  I long ago as a student wrong a
shell which simply did ln [binarytorun] banana; execve(.."banana", ...)

So I agree its not security related. You just need to fix the
implementation

> +		case PR_SET_NAME: {
> +			struct task_struct *me = current;
> +			me->comm[sizeof(me->comm)-1] = 0;
> +			if (strncpy_from_user(me->comm, (char *)arg2, sizeof(me->comm)-1) < 0)
> +				return -EFAULT;
> +			return 0;
> +		}

If the strncpy_from_user faults the state of current->comm is undefined.
This strikes me as bad design.

Alan
