Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVCQR5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVCQR5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 12:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVCQR5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 12:57:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:33924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261191AbVCQR53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 12:57:29 -0500
Date: Thu, 17 Mar 2005 09:57:03 -0800
From: Chris Wright <chrisw@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Audit Discussion <linux-audit@redhat.com>,
       Ondrej Zary <linux@rainbow-software.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Syscall auditing - move "name=" field to the end
Message-ID: <20050317175703.GE28536@shell0.pdx.osdl.net>
References: <4238A65C.7020908@rainbow-software.org> <20050316224117.GC28536@shell0.pdx.osdl.net> <1111026301.6833.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111026301.6833.38.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Woodhouse (dwmw2@infradead.org) wrote:
> On Wed, 2005-03-16 at 14:41 -0800, Chris Wright wrote:
> > * Ondrej Zary (linux@rainbow-software.org) wrote:
> > > This patch moves the "name=" field to the end of audit records. The 
> > > original placement is bad because it cannot be properly parsed. It is 
> > > impossible to tell if the name is "/bin/true" or "/bin/true inode=469634 
> > > dev=00:00" because the "inode=" and "dev=" fields can be omitted.
> 
> Consider: 
> 
> open("/bin/true\naudit(1111008484.824:89346): ...", O_RDONLY);
> 
> I don't think this patch is enough -- either we need to escape the text
> completely or just dump it as hex instead of a string. One option would
> be to dump it in quotes as a string if all chars in the string are in
> the range 0x20-0x7e, and as hex otherwise. That slightly complicates the
> parsing, but not by much, and still gives you plain text in the majority
> of cases while protecting against abuse.

Yes good point.  I don't have a strong preference.  Steve, are you
working on processing log data, do you have a preference?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
