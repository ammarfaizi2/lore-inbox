Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUBWWem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUBWWem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:34:42 -0500
Received: from zeus.kernel.org ([204.152.189.113]:45224 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262060AbUBWWeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:34:37 -0500
Date: Mon, 23 Feb 2004 22:29:28 +0000
From: Joe Thornber <thornber@redhat.com>
To: Mike Christie <mikenc@us.ibm.com>
Cc: Joe Thornber <thornber@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/6] dm: endio method
Message-ID: <20040223222928.GB14731@reti>
References: <20040220153145.GN27549@reti> <20040220153403.GO27549@reti> <40372BCE.7090708@us.ibm.com> <20040223100512.GB943@reti> <403A79E0.6080609@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403A79E0.6080609@us.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 02:08:32PM -0800, Mike Christie wrote:
> With this move if the path has to be activated first, will the daemon 
> have to call some sort of ps_path_is_initialized() function before it 
> calls generic_make_request?

Yes, I am planning to add something like this.  Whether it needs to be
per path, or we could get away per priority group is probably a
question that you could answer better than me ?  Do we need a
corresponding deactivate for some hardware ?

> tio's map_info so it could be set from the daemon, or mp may need to 
> allocate its own io wrapper. It seems the latter may now be needed to 
> give ps's a a map_info, becuase dm-mpath needs to store the path in the 
> tio's map_info.

I think the bio recording/reset is going to have to move inside the
target.  It makes sense that the mpath target should be the only one
that incurs this overhead.  So yes, there will have to be a wrapper
which could be used to provide context for the ps.

- Joe
