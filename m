Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUANOUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUANOUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:20:19 -0500
Received: from [12.177.129.25] ([12.177.129.25]:29379 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261605AbUANOUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:20:14 -0500
Date: Wed, 14 Jan 2004 09:41:31 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] /dev/anon
Message-ID: <20040114144131.GA6407@ccure.user-mode-linux.org>
References: <20040114014209.GA4301@ccure.user-mode-linux.org> <Pine.LNX.4.44.0401131817121.12810-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401131817121.12810-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 08:46:23PM -0800, Davide Libenzi wrote:
> What do you mean for throw out data? If you mean writing DONTNEED'ed 
> dirty pages to the backed up file and release them to the page cache, it 
> does. 

Writing dirty pages to backing store isn't throwing them out.

> If you mean stop handling page faults inside the DONTNEED'ed region, 
> it does not. 

This is kind of moot since the region won't be mapped anywhere, so there
can't be page faults on it.

> If you mean zero-filling (ala ftruncate()) the DONTNEED'ed 
> region, it obviously does not. 

Yes, I mean this, as a side-effect of dropping the region as though it were
clean.

> I thought your goal was to release memory 
> to the host, that's why I proposed sys_madvise(MADV_DONTNEED).

It is, I want memory released immediately as though it were clean, and
MADV_DONTNEED doesn't help.

				Jeff
