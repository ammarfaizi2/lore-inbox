Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWDTSMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWDTSMb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 14:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWDTSMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 14:12:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7112 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751221AbWDTSMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 14:12:30 -0400
Date: Thu, 20 Apr 2006 11:08:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Chris Wright <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       Christoph Hellwig <hch@infradead.org>, tonyj@suse.de,
       James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make security_ops EXPORT_SYMBOL_GPL()
In-Reply-To: <20060420170153.GA3237@kroah.com>
Message-ID: <Pine.LNX.4.64.0604201104510.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604191221100.4408@d.namei> <20060419181015.GC11091@kroah.com>
 <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil> <20060420150037.GA30353@kroah.com>
 <1145542811.3313.94.camel@moss-spartans.epoch.ncsc.mil> <20060420161552.GA1990@kroah.com>
 <20060420162309.GA18726@infradead.org> <1145550897.3313.143.camel@moss-spartans.epoch.ncsc.mil>
 <20060420164651.GA2439@kroah.com> <1145552412.3313.150.camel@moss-spartans.epoch.ncsc.mil>
 <20060420170153.GA3237@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Apr 2006, Greg KH wrote:
>
> Some closed source modules are taking advantage of the fact that the
> security_ops variable is available to them, so they are using it to hook
> into parts of the kernel that should only be available to "real" users
> of the LSM interface (which is required to be under the GPL.)

I'm really not going to apply this.

It's insane. 

"security_ops" is used by _anything_ that uses the inline functions in 
<linux/security.h>, which suddenly means that a non-GPL module cannot use 
_any_ of the standard security tests. That's insane.

And there's no point to this patch. The "explanation" I have seen so far 
is that some strange root-kit could take over the security ops. That's 
just crazy talk. If you're a root-kit, would you care about the copyright 
license? No. So this patch just makes zero sense from any standpoint.

If people want to remove security_ops, that's fine (not for 2.6.17, but 
assuming you guys can come to some reasonable agreement, at some later 
date). But turning it into a GPL-only, but leaving all the infrastructure 
requiring it is not.

		Linus
