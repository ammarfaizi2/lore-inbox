Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVIKRXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVIKRXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVIKRXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:23:44 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:49186 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751081AbVIKRXn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:23:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TQ7N63bOIcw/R+oox3QD49WXPEpnGhmTwgM/DnhGWrRbSpntGn1BWrAeqCI0bqvxlvGN7uVB8WMDaGSH8U0pzoesoq0/ytJbsN6hbLztMot8VEg0rqyL2LQvdur25EZj2gk+n968sgXh8o0HML1goIS/yOsx7xV9CnYFPSA8Jgo=
Message-ID: <4301cff60509111023787cdaf1@mail.gmail.com>
Date: Sun, 11 Sep 2005 20:23:37 +0300
From: Mika Kukkonen <mikukkon@iki.fi>
Reply-To: Mika Kukkonen <mikukkon@iki.fi>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix allnoconfig build with gcc4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509101356320.30958@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050910201913.GA6179@miku.homelinux.net>
	 <Pine.LNX.4.58.0509101356320.30958@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
(...)
> No, this would cause a compile error if CONFIG_NET and CONFIG_SYSCTL
> is enabled (because sysctl_net.c needs that declaration).

Ah yes. I got confused by googling which showed that there are some issues
with these declarations and gcc4 (see for example this thread:
http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html).

> So the correct solution is apparently either one of
> 
>  - always declare an empty "struct ctl_table" regardless of whether SYSCTL
>    is enabled or not.
> 
>    This might be a good idea, since it probably allows more code to be
>    compiled without checking for CONFIG_SYSCTL.
> 
>  - put the ether_table[] declaration inside a #ifdef CONFIG_SYSCTL.

core_table in include/net/sock.h uses the latter option, so I'll send
you a patch
for that (with better email client).

--MiKu
