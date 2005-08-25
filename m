Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVHYVNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVHYVNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbVHYVNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:13:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751475AbVHYVNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:13:15 -0400
Date: Thu, 25 Aug 2005 14:12:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: serue@us.ibm.com
Cc: Chris Wright <chrisw@osdl.org>, linux-security-module@wirex.com,
       Greg Kroah <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Kurt Garloff <garloff@suse.de>, James Morris <jmorris@redhat.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH 5/5] Remove unnecesary capability hooks in rootplug.
Message-ID: <20050825211236.GZ7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <20050825012150.490797000@localhost.localdomain> <20050825143807.GA8590@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825143807.GA8590@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* serue@us.ibm.com (serue@us.ibm.com) wrote:
> @@ -1527,7 +1533,8 @@ static int selinux_vm_enough_memory(long
>  	int rc, cap_sys_admin = 0;
>  	struct task_security_struct *tsec = current->security;
>  
> -	rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
> +	rc = secondary_ops->capable ?
> +		secondary_ops->capable(current, CAP_SYS_ADMIN) : 0;

I don't think this really makes sense.  It says the default secondary
thinks you have the capablity.  Safe since SELinux double checks, but
not really accurate.

thanks,
-chris
