Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUCVFz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 00:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUCVFz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 00:55:58 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:62802 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261745AbUCVFz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 00:55:57 -0500
Date: Mon, 22 Mar 2004 06:56:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Michael Still <mikal@stillhq.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Makefile dependancies: scripts depending on configured kernel?
Message-ID: <20040322055617.GA2250@mars.ravnborg.org>
Mail-Followup-To: Michael Still <mikal@stillhq.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <405E1427.6080309@stillhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405E1427.6080309@stillhq.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 09:16:07AM +1100, Michael Still wrote:
> 
> Hey,
> 
> the top level Makefile specifies that the scripts depend on the kernel 
> being configured before the scripts can be built:
> 
> scripts: scripts_basic include/config/MARKER
> 	$(Q)$(MAKE) $(build)=$(@)
> 
> I think that this is probably a problem, because it means people can't 
> build any of the documentation targets without having configured the kernel.

The dependency for docs is (now) wrong.
It should be:
# Documentation targets
# ---------------------------------------------------------------------------
%docs: scripts_basic FORCE
        $(Q)$(MAKE) $(build)=Documentation/DocBook $@

docproc is the only binary used by Documentation/Docbook, and it is already
placed in scripts_basic.

Trivial - so I will include this in some other kbuild patch
I'm preparing.

> Do any of the scripts actually depend on a configured kernel to build? 
Yes, several of the ninaries do so. Among others empty.o.

> How can I verify that none of them need a configured kernel? Commenting 
> out the dependancy didn't break anything.
Test a bit more, and you will see they are indeed needed.
Note, some archs other than i386 have a bit different requirements
because thay do not use an asm-offsett.h file.

	Sam
