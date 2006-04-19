Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWDSWMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWDSWMu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWDSWMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:12:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21657 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751280AbWDSWMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:12:49 -0400
Date: Wed, 19 Apr 2006 23:12:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 10/11] security: AppArmor - Add flags to d_path
Message-ID: <20060419221248.GB26694@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
	chrisw@sous-sol.org, linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175026.29149.23661.sendpatchset@ermintrude.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419175026.29149.23661.sendpatchset@ermintrude.int.wirex.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 10:50:26AM -0700, Tony Jones wrote:
> This patch adds a new function d_path_flags which takes an additional flags
> parameter.   Adding a new function rather than ammending the existing d_path
> was done to avoid impact on the current users.
> 
> It is not essential for inclusion with AppArmor (the apparmor_mediation.patch
> can easily be revised to use plain d_path) but it enables cleaner code 
> ["(delete)" handling] and closes a loophole with pathname generation for 
> chrooted tasks. 
> 
> It currently adds two flags:
> 
> DPATH_SYSROOT:
> 	d_path should generate a path from the system root rather than the
> 	task's current root. 
> 
> 	For AppArmor this enables generation of absolute pathnames in all
> 	cases.  Currently when a task is chrooted, file access is reported
> 	relative to the chroot.  Because it is currently not possible to 
> 	obtain the absolute path in an SMP safe way, without this patch 
> 	AppArmor will have to report chroot-relative pathnames.

This is utter bullshit.  There is no such thing as a system root,
and should not rely on pathes making any sense for anything but the
process using at at this point of time.  This stuff will not get in either
in d_path or whatever duplicate of it you'd try to submit.

