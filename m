Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVCDGkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVCDGkD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVCDGkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:40:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:58279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262149AbVCDGgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:36:13 -0500
Date: Thu, 3 Mar 2005 22:34:21 -0800
From: Chris Wright <chrisw@osdl.org>
To: Russell Miller <rmiller@duskglow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: auditing subsystem
Message-ID: <20050304063421.GS28536@shell0.pdx.osdl.net>
References: <200503032218.12062.rmiller@duskglow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503032218.12062.rmiller@duskglow.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell Miller (rmiller@duskglow.com) wrote:
> I've been doing a lot of research on this, and I keep coming up with things 
> that don't work, have been abandoned, or are almost impossible to find or get 
> working.  So I'll ask here.  Maybe one of the ultra-elightened linux gods 
> will have a ready answer.

You'll have better luck using linux-audit list.

> I want to be able to audit system calls - I want to log when files are opened, 
> created, changed, deleted, etc.  Preferably I would like to do it without 
> having to apply kernel patches, using vanilla (or close to vanilla) kernel.  
> If this isn't possible, my net preference is to use a module.  If this isn't 
> possible, well, I'll do what I have to.

No patches needed (although you will want 2.6.11 because the inode filter
was busted, and you'll likely want to use it), for opened anyway.  You'll
need an additional auditfs patch for created/deleted/changed(for more
than just knowing open w/ write access) and it's not a stable patch yet.

> I notice there is a CONFIG_AUDIT option.  Is this what I am looking for, and 
> how do I use it?  /dev/audit seems not to work...

You'll need auditd, auditctl, and some rules to capture what you care
about.

For example:

To watch accesses to /etc/passwd (not creation/deletion events).

# auditd
# auditctl -a entry,possible -S open
# auditctl -a exit,always -S open -F inode=(inode of /etc/passwd)

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
