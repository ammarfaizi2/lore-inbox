Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWI3Ie5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWI3Ie5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWI3Ie4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:34:56 -0400
Received: from 1wt.eu ([62.212.114.60]:32019 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750751AbWI3Ie4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:34:56 -0400
Date: Sat, 30 Sep 2006 10:05:04 +0200
From: Willy Tarreau <w@1wt.eu>
To: Olaf Hering <olaf@aepfle.de>
Cc: sam@ravnborg.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add XARGS to toplevel Makefile
Message-ID: <20060930080504.GO541@1wt.eu>
References: <20060928060224.GA16290@aepfle.de> <20060930075427.GA6858@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930075427.GA6858@aepfle.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olaf,

On Sat, Sep 30, 2006 at 09:54:27AM +0200, Olaf Hering wrote:
> 
> run xargs with --no-run-if-empty to avoid random failures:
> 
>   MAKE   tags
> ctags: No files specified. Try "ctags --help".
> make: *** [tags] Error 123

> +# assume xargs comes from GNU findutils or GNU coreutils
> +XARGS		= $(shell if [ "$$(uname -s)" = "Linux" ]; then echo "xargs --no-run-if-empty" ; else echo "xargs" ; fi )

I'd rather test xargs' support for the option than check the OS with uname.
Something like the following might a little bit be more appropriate :

XARGS		= $(shell if xargs --no-run-if-empty true </dev/null 2>/dev/null; then echo "xargs --no-run-if-empty" ; else echo "xargs" ; fi )

Best regards,
Willy

