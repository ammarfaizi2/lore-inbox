Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVFXNEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVFXNEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 09:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVFXNEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 09:04:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:25315 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262428AbVFXNDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 09:03:47 -0400
Date: Fri, 24 Jun 2005 18:30:49 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] files: change fd_install assertion
Message-ID: <20050624130049.GG4804@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050624105011.GB4804@in.ibm.com> <20050624105209.GC4804@in.ibm.com> <20050624105318.GD4804@in.ibm.com> <20050624105410.GE4804@in.ibm.com> <42BBF6D5.2030109@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BBF6D5.2030109@oktetlabs.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 04:04:37PM +0400, Artem B. Bityuckiy wrote:
> Dipankar Sarma wrote:
> >-	if (unlikely(fdt->fd[fd] != NULL))
> >-		BUG();
> >+	BUG_ON(fdt->fd[fd] != NULL);
> > 	rcu_assign_pointer(fdt->fd[fd], file);
> > 	spin_unlock(&files->file_lock);
> > }
> >
> Why is this better ?

Because that way the compare and branch can be ifdefed out when CONFIG_BUG is
not set. Not to mention BUG_ON() looks more like an assertion.

Thanks
Dipankar
