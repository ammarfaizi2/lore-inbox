Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVBRCCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVBRCCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 21:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVBRCC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 21:02:29 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:58017 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S261254AbVBRCC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 21:02:26 -0500
Date: Fri, 18 Feb 2005 10:02:20 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: dtor_core@ameritech.net, John M Flinchbaugh <john@hjsoft.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp, resume and kernel versions
Message-ID: <20050218020220.GD30342@blackham.com.au>
References: <200502162346.26143.dtor_core@ameritech.net> <20050217110731.GE1353@elf.ucw.cz> <20050217162847.GA32488@butterfly.hjsoft.com> <d120d5000502170930ccc3e9e@mail.gmail.com> <20050217195651.GB5963@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050217195651.GB5963@openzaurus.ucw.cz>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 08:56:52PM +0100, Pavel Machek wrote:
> > > Just remember you're doing the mkswap if you decide to rearrange your
> > > partitions at all, or code a script smart enough to grep your swap
> > > partitions out of your fstab.
> > 
> > It could be a workaround. Still it will cause loss of unsaved work if
> > I happen to load wrong kernel. Given that the code checking for swsusp
> > image can be marked __init I don't understand the reasons gainst doing
> > it.
> 
> How do you know which partitions to check? swsusp gets it from resume= parameter,
> but if you do not have it compiled, you probably have wrong cmdline, too.

In many cases, you might have added the resume= line to every kernel
that's booted (eg, LILO's global append= parameter, or Debian GRUB's
magic kopts gear). Alternately (or additionally), you could examine
the signature when sys_swapon is called on a swap partition (though
the code couldn't be __init then).

These together I want to claim would catch many of these cases, and
any effort to avoid severe filesystem corruption is a good thing.

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
