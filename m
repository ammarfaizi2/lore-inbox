Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWDSWKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWDSWKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWDSWKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:10:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20377 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751278AbWDSWKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:10:41 -0400
Date: Wed, 19 Apr 2006 23:10:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace semaphore
Message-ID: <20060419221038.GA26694@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
	chrisw@sous-sol.org, linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 10:50:34AM -0700, Tony Jones wrote:
> This patch exports the namespace_sem semaphore.
> 
> The shared subtree patches which went into 2.6.15-rc1 replaced the old
> namespace semaphore which used to be per namespace (and visible) with a
> new single static semaphore.
> 
> The reason for this change is that currently visibility of vfsmount information
> to the LSM hooks is fairly patchy.  Either there is no passed parameter or
> it can be NULL.  For the case of the former,  several LSM hooks that we
> require to mediate have no vfsmount/nameidata passed.  We previously (mis)used
> the visibility of the old per namespace semaphore to walk the processes 
> namespace looking for vfsmounts with a root dentry matching the dentry we were 
> trying to mediate.  
> 
> Clearly this is not viable long term strategy and changes working towards 
> passing a vfsmount to all relevant LSM hooks would seem necessary (and also 
> useful for other users of LSM). Alternative suggestions and ideas are welcomed.

Just don't do it.  No module has any business looking in there, and no
non-modular code outside a few files in fs/ either.
