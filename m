Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWAQF3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWAQF3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 00:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWAQF3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 00:29:11 -0500
Received: from mail.autoweb.net ([198.172.237.26]:58839 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750722AbWAQF3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 00:29:09 -0500
Date: Tue, 17 Jan 2006 00:27:59 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: git-diff-files and fakeroot
Message-ID: <20060117052758.GA22839@mythryan2.michonline.com>
References: <43CC5231.3090005@michonline.com> <7vzmlvk2bs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vzmlvk2bs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 06:36:39PM -0800, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > I've been trying to track down a strange issue with building kernels
> > (and scripts/setlocalversion) and finally realized the problem was the
> > when run under fakeroot, git-diff-files thinks everything is changed
> > (deleted, I believe)
> 
> BTW, Ryan, I suspect this is where you try to append "-dirty" to
> the version number.  But I wonder why you are doing the build
> under fakeroot to begin with?  Wasn't the SOP "build as
> yourself, install as root"?

That's exactly what started this search, because I was running
"make deb-pkg". (Effectively.)  dpkg-buildpackage wants to think it is
running as root, either via sudo or via fakeroot.  I had my build
environment switched over entirely to fakeroot, as it just seems to be a
better practice, but I've temporarily switched back to sudo.

However, your explanation has pointed out to me how I can solve this -
run "fakeroot -u" instead of "fakeroot", and I think it will be fixed.

lkml cc:ed to hopefully stick this in an archive where someone else will
find it.





-- 

Ryan Anderson
  sometimes Pug Majere
