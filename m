Return-Path: <linux-kernel-owner+w=401wt.eu-S1755427AbXABVkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbXABVkf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755430AbXABVke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:40:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:53844 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755426AbXABVkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:40:33 -0500
Date: Tue, 2 Jan 2007 15:40:27 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Mimi Zohar <zohar@us.ibm.com>
Cc: Daniel Walker <dwalker@mvista.com>, akpm@osdl.org,
       kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Should be [PATCH -mm] --  Re: [PATCH -rt] panic on SLIM + selinux
Message-ID: <20070102214026.GA13887@sergelap.austin.ibm.com>
References: <1167494007.14081.75.camel@imap.mvista.com> <OF9AB42A1E.A7654F8F-ON85257257.0061FF6C-85257257.00642493@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9AB42A1E.A7654F8F-ON85257257.0061FF6C-85257257.00642493@us.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mimi Zohar (zohar@us.ibm.com):
> Being able to compile both SELinux and SLIM into the kernel was done
> intentionally.

Intentionally so that you can switch back and forth for testing?

> The kernel parameters 'selinux' and 'slim' can enable
> or disable the LSM module at boot.  Perhaps, for the time being, the
> SECURITY_SLIM_BOOTPARAM_VALUE should default to 0.

That should solve the problem for most people.  People wanting to
test with slim will still have to specify 'selinux=0' or get the
boot failure.  But I suspect that having selinux automatically
not load when slim is loaded will be considered too unsafe?

Mimi, what about moving slim down below selinux in the Makefile,
and having slim refuse to load if security_ops is not an _ops you
know about (i.e. dummy_ops or capability_ops)?  Then you can leave
SECURITY_SLIM_BOOTPARAM_VALUE as 1, and users just have to say
'selinux=0' to boot slim?  Just a thought, maybe less intuitive...

-serge
