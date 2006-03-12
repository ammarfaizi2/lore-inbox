Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWCLWlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWCLWlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCLWlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:41:09 -0500
Received: from ns.suse.de ([195.135.220.2]:3201 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751254AbWCLWlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:41:07 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [discuss] Re: 2.6.16-rc5-mm3: spinlock bad magic on CPU#0 on AMD64
Date: Sun, 12 Mar 2006 16:10:31 +0100
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Mingming Cao <cmm@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>
References: <200603120024.04938.rjw@sisk.pl> <200603121349.32374.rjw@sisk.pl> <20060312142654.650b90fb.akpm@osdl.org>
In-Reply-To: <20060312142654.650b90fb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603121610.31881.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 March 2006 23:26, Andrew Morton wrote:

> 
> It's a pretty vile backtrace.  I supposed you have CONFIG_FRAME_POINTER=n.

Won't make a difference because the oops backtracer doesn't
use them.

> Still.  It seems that what's happened is that we took a pagefault while
> reiserfs had a transaction open.  The fault is against a mmapped ext3 file
> and we ended up in the recently-reworked ext3_get_block() which tests
> journal_current_handle() to work out whether we're in a write or a read. 
> oops.  The presence of reiserfs journal_info makes it decide it's a write,
> not a read so it starts treating a reiserfs journal_info as an ext3 one.
> 
> The code used to work OK because it was only for direct-IO, which doesn't
> get recurred into like this.  But it got used for regular I/O in -mm.

Oops. Can this happen in more situations?

-Andi
