Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVHDMXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVHDMXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVHDMVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:21:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28870 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262504AbVHDMTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:19:38 -0400
To: zach@vmware.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3/5 explicit-iopl
References: <200508040043.j740hi0R004184@zach-dev.vmware.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Aug 2005 14:19:37 +0200
In-Reply-To: <200508040043.j740hi0R004184@zach-dev.vmware.com.suse.lists.linux.kernel>
Message-ID: <p73k6j1rj1i.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zach@vmware.com writes:
> 
> Unfortunately, this added one field to the thread_struct.  But as a bonus, on
> P4, the fastest time measured for switch_to() went from 312 to 260 cycles, a
> win of about 17% in the fast case through this performance critical path.

Cool! Definitely want this on x86-64 too.

Can we perhaps get rid of the PUSHF/POPF in the SYSENTER syscall path too?
iirc they were only for single stepping. But SYSENTER doesn't disable
single stepping, so the debug handler could detect this and set
some magic flag that restores it on syscall exit.

-Andi
