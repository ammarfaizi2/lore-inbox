Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422773AbWBICRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWBICRv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 21:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422775AbWBICRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 21:17:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:23172 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422773AbWBICRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 21:17:50 -0500
Date: Thu, 9 Feb 2006 02:17:49 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] fix handling of st_nlink on procfs root
Message-ID: <20060209021749.GM27946@ftp.linux.org.uk>
References: <E1F6vyO-00009r-3a@ZenIV.linux.org.uk> <m17j855om3.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j855om3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 06:04:36PM -0700, Eric W. Biederman wrote:
> There are some other similar problems still in /proc.
> 
> In my pid namespace work I have some managed to clean most of
> this up, and finally split proc into two filesystems.
> 
> The only was I was able to get the union to work was
> to let lookup return files in an internal mount.
> 
> The only problem was that /proc/irq/..  != /proc/

That's not the only problem here, unfortunately.

> I will finish all of this up shortly but do you know a good
> way to do a union mount when we mount proc?

Not transparently; mount(2) should _not_ mount two filesystems at once.
Note that you'll run into serious problems as soon as you try to mount/umount/
mount --move the stuff there.  And doing unionfs <spit> approach will cause
fsckloads of fun issues with lifetimes.
