Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbUJ1Q7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbUJ1Q7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbUJ1Q7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:59:08 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:12397 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261751AbUJ1Q7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:59:02 -0400
Date: Thu, 28 Oct 2004 20:59:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: kbuild/all archs: Sanitize creating offsets.h 
Message-ID: <20041028185917.GA9004@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When creating offsets.h from arch/$(ARCH)/Makefile we failed to check
all dependencies. A few key dependencies were listed - but a manually
edited list of include files are bound to be incomplete.
A few times I have tried building a kernel - which failed because
offsets.h needed to be updated but kbuild failed to do so.
I wonder what could happen with a kernel with an out-dated offsets.h
file with wrong assembler constants.

This serie of patches fixes this.
Generating offsets.h is moved to include/asm-$(ARCH)/Kbuild and
the usual dependency tracking is used to detect when an update is needed.

With this mail four patches are posted:
o Accept kbuild file named Kbuild
o generic support for offsets.h
o changes for i386
o changes for arm

The second patch breaks all architectures...

My bk tree at bk://linux-sam.bkbits.net/kbuild contains support for most
architectures (sh and cris missing for now).

	Sam
