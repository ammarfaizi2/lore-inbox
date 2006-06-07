Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWFGWkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWFGWkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWFGWkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:40:43 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:39043 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932446AbWFGWkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:40:42 -0400
Date: Wed, 7 Jun 2006 15:43:26 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>
Subject: Re: HOWTO add privileged code to the kernel without breaking LSM/SELinux
Message-ID: <20060607224326.GM2697@moss.sous-sol.org>
References: <Pine.LNX.4.64.0606060229240.10150@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606060229240.10150@d.namei>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@namei.org) wrote:
> If you add any new code to the kernel which exposes any kind of 
> privileged operation to userspace, then it probably needs an LSM hook and 
> subsequent changes to SELinux.
> 
> It would certainly be unreasonable to expect all kernel developers to know 
> how to do this, however, it is usually very simple to determine when a new 
> LSM would be needed as a first step.
> 
> The simple tests are: does the code you're adding perform any new DAC 
> checks involving any of the user or group ID fields of a task?  Did you 
> add a capable() call?  Does it call DAC helper functions?

The set_task_ioprio changes would make a nice concrete example.

> If so, it's possible that a corresponding MAC check needs to be added via 
> LSM; and I'd ask that you simply cc any or all of the LSM and/or SELinux 
> maintainers when posting such patches upstream for RFC or inclusion.  We 
> can work on the LSM and SELinux side of things if needed.
> 
> This will not cover every case, but I think it will cover most of the ones 
> that are likely to come up in the future.  If in doubt, it won't hurt to ask.

On a related note.  When adding sysfs files, file perms (and for SELinux,
super block label) are the lowest common denominator for protections,
but should also be considered the last resort.  Smth 0644 may need e.g,
an explicit capable() check in ->store (in addition to the implicit
permission() check).

thanks,
-chris
