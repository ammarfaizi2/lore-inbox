Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268396AbUIAFJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268396AbUIAFJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 01:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268526AbUIAFJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 01:09:32 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:46636 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268396AbUIAFJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 01:09:30 -0400
Date: Wed, 1 Sep 2004 07:11:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: kbuild: Support LOCALVERSION
Message-ID: <20040901051127.GA7198@mars.ravnborg.org>
Mail-Followup-To: Ian Wienand <ianw@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@lst.de>
References: <20040831192642.GA15855@mars.ravnborg.org> <20040901010840.GL2897@cse.unsw.EDU.AU> <20040901012422.GM2897@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901012422.GM2897@cse.unsw.EDU.AU>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 11:24:22AM +1000, Ian Wienand wrote:
 
> Sorry to reply to myself, but I forgot to include a suggested patch
> (attached).
> 
Thanks for the fix.
  
> @@ -763,7 +770,7 @@
>  	)
>  endef
>  
> -include/linux/version.h: Makefile
> +include/linux/version.h: $(srctree)/Makefile $(localversion-files)
>  	$(call filechk,version.h)
>  

We could just make this:
include/linux/version.h: FORCE
       $(call filechk,version.h)

Then version.h would be updated also if LOCALVERSION is specified on 
the command line.
Only issue is that it will always be checked - but the same goes for 
a few other files.

	Sam
