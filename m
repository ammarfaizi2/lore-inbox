Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVIOIKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVIOIKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVIOIKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:10:35 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:56413 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750945AbVIOIKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:10:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=OhxIGEi2Mr44tFYloFYSS3BXar8lhSpxLgYxNU/uKSO2HF69nCrv8UQaIiB9KOO+WnAdD9C3D744GYCxEYqN94unahVWafoJTtot76ATOSVQV1W3rNhfqbYcY6Xdj/uzDGOZsDipVN1FoaeRhp4nymuLP27vuJF3waWQ/f9kmE8=
Date: Thu, 15 Sep 2005 12:20:50 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Separate tainted code from panic code
Message-ID: <20050915082049.GA29266@mipter.zuzino.mipt.ru>
References: <20050913230718.GA14867@mipter.zuzino.mipt.ru> <20050913172816.35835b66.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913172816.35835b66.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 05:28:16PM -0700, Andrew Morton wrote:
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > * Create kernel/tainted.c and include/linux/tainted.h
> >  * Move all tainted-related stuff from kernel/panic.c and
> >    include/linux/kernel.h there.
> >  * #include <linux/tainted.h> where needed.
> >  * Switch #include <linux/kernel.h> to #include <linux/tainted.h> in
> >    kernel/module.c and mm/page_alloc.c . Said includes were added during
> >    add_taint() propagation and tainted stuff was in kernel.h back then.
> 
> Why?  What reason is there for making these changes?

Most tainted users are in arch/$ARCH/kernel/. The rest including
kernel.h don't want tainted stuff. And kernel.h is used often.

