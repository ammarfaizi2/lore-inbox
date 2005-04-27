Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVD0Nvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVD0Nvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVD0NpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:45:07 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:46549 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261591AbVD0Nmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:42:43 -0400
Date: Wed, 27 Apr 2005 09:42:33 -0400
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       viro@math.psu.edu, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without clear_inode() call between
Message-ID: <20050427134233.GB9454@delft.aura.cs.cmu.edu>
Mail-Followup-To: "Artem B. Bityuckiy" <dedekind@infradead.org>,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	viro@math.psu.edu, linux-fsdevel@vger.kernel.org
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.5.9i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 05:15:41PM +0400, Artem B. Bityuckiy wrote:
> Dear VFS developers,
> 
> is it possible to review/comment/apply the patch which fixes a severe
> VFS bug which screws up JFFS2? 
> 
> (the third attempt).

I think this is a problem that hit Coda at some point. We used to have a
linked list that linked all the inodes together. However not long after
the RCU changes, I noticed that this linked list occasionally got
corrupted. I didn't want to dig too deep into all the dcache related
changes where I thought the problem came from, nobody else seemed to be
complaining and the linked list wasn't really necessary so I worked
around the problem by removing the linked list strucure.

But I think you found the actual cause and this patch looks good to me,
it probably should get merged.

Jan
