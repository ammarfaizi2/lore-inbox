Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264220AbTKTBr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 20:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264222AbTKTBr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 20:47:27 -0500
Received: from holomorphy.com ([199.26.172.102]:36779 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264220AbTKTBrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 20:47:25 -0500
Date: Wed, 19 Nov 2003 17:47:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christopher Li <lkml@chrisli.org>
Cc: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120014718.GA22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christopher Li <lkml@chrisli.org>,
	Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar> <20031119223425.GA20549@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119223425.GA20549@64m.dyndns.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 05:34:25PM -0500, Christopher Li wrote:
> Can you send me a few more lines of the log file before and after that message? I can take
> a look at what is going on there. Most likely vmmon driver get confused.

You should have a vm_ops->nopage() method that didn't get updated.
The formerly-unused argument got turned into a status return pointer,
so you need to do something like:

struct page *vmmon_nopage(struct vm_area_struct *vma, unsigned long addr, int *type)
{
	...
	if (type)
		*type = VM_FAULT_MINOR;
	return page;
}

It should also give off a big fat warning about initialization from
incompatible pointer types when compiled.


-- wli
