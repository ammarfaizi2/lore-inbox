Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUHCTFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUHCTFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 15:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUHCTFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 15:05:39 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:5158 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266808AbUHCTFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 15:05:31 -0400
Date: Tue, 3 Aug 2004 21:06:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Lei Yang <leiyang@nec-labs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: modversion.h in kernel 2.6.x
Message-ID: <20040803190649.GA20041@mars.ravnborg.org>
Mail-Followup-To: Lei Yang <leiyang@nec-labs.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>
References: <1091570120.5487.82.camel@bijar.nec-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091570120.5487.82.camel@bijar.nec-labs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 02:55:20PM -0700, Lei Yang wrote:
> Hello,
> 
> Could anyone tell me what happened with modversion.h in 2.6.x? I want to
> build a module whose makefile indicates that,
> 
> ifdef CONFIG_MODVERSIONS
> MODVERSIONS:= -DMODVERSIONS -include
> $(KERNEL_DIR)/include/linux/modversions.h
> CKERNOPS += $(MODVERSIONS)
> endif

This is a sign of a broken module.
Request the author to use the kbuild infrastructure when building the module.
See Documentation/kbuild/modules.txt and Driver porting series at lwn.net for
good examples.

If you do not need CONFIG_MODVERSION then try to disable it and compile
the module, you may be lucky that it works.

But be carefull not to enable any options that may change ABI, for example reg-parm=3
is know to cause problems if not used consistently.

	Sam
