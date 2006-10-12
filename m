Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWJLTGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWJLTGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWJLTGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:06:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:19943 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750983AbWJLTGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:06:50 -0400
Date: Thu, 12 Oct 2006 14:06:47 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Serge Aleynikov <serge@hq.idt.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@redhat.com>
Subject: Re: non-critical security bug fix
Message-ID: <20061012190647.GA6725@sergelap.austin.ibm.com>
References: <452D3ED9.509@hq.idt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452D3ED9.509@hq.idt.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge Aleynikov (serge@hq.idt.net):
> To Maintainers of the linux/security/commoncap.c:
> 
> Patch description:
> ==================
> This bug-fix ensures that if a process with root access sets 
> keep_capabilities flag, current capabilities get preserved when the 
> process switches from root to another effective user.  It looks like 
> this was intended from the way capabilities are documented, but the 
> current->keep_capabilities flag is not being checked.

Note that without your patch, the permitted set is maintained, so that
you can regain the caps into your effective set after setuid if you
need.  i.e.

	prctl(PR_SET_KEEPCAPS, 1);
	setresuid(1000, 1000, 1000);
	caps = cap_from_text("cap_net_admin,cap_sys_admin,cap_dac_override=ep");
	ret = cap_set_proc(caps);

So this patch will change the default behavior, but does not add
features or change what is possible.

Ordinarely I'd say changing default behavior wrt security is a bad
thing, but given that this is "default behavior when doing prctl(PR_SET_KEEPCAPS)",
I don't know how much it matters.

Still, I like the current behavior, where setuid means drop effective
caps no matter what.

-serge
