Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUGLKIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUGLKIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 06:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUGLKIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 06:08:50 -0400
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:27041 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S266775AbUGLKIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 06:08:48 -0400
Date: Mon, 12 Jul 2004 12:08:44 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: linux-kernel@vger.kernel.org
Subject: Problem with __user annotation in drivers/block/ida_ioctl.h
Message-ID: <20040712100843.GA17273@hout.vanvergehaald.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the cpqarrayd-2.0 daemon in order to monitor the volumes that
are managed by the cciss driver. After I upgraded the kernel to 2.6.7
(coming from 2.6.0), the compilation of the daemon failed because of the
__user annotation that was added in the file drivers/block/ida_ioctl.h
as part of the sparse fixes.

I did some research (read: googling) and found out that this could
be solved by including /usr/src/linux/include/linux/compiler.h.
To prove this, I inserted #include statements for the compiler.h file in
all source files of the cpqarrayd-2.0 daemon where ida_ioctl.h was included.
With these changes the daemon compiled and ran without problems.

QUESTION: what is the right fix for this?
I think the header file linux/compiler.h needs to be included in
the file drivers/block/ida_ioctl.h.  This way we prevent all user
space tools from breaking.  Am I right?

Regards,
Toon.
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
