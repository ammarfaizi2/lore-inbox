Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWGSSYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWGSSYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 14:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWGSSYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 14:24:03 -0400
Received: from ptb-relay03.plus.net ([212.159.14.214]:2202 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S932545AbWGSSYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 14:24:02 -0400
Message-ID: <44BE78C0.4020909@mauve.plus.com>
Date: Wed, 19 Jul 2006 19:24:00 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Per-user swap devices.
References: <44BE015E.5080107@mauve.plus.com> <200607191500.k6JF09EQ005021@turing-police.cc.vt.edu>
In-Reply-To: <200607191500.k6JF09EQ005021@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 19 Jul 2006 10:54:38 BST, Ian Stirling said:
> 
>>It would be really nice to be able to simply: chown crashalot.users 
>>/dev/swap0 ;swapon /dev/swap0
>>Then anything run by crashalot would swap to /dev/swap0 - and not locally.

> This doesn't look like it will do as much good as you think.  The problem
> is what to do when something run by some *other* UID needs a page - you need
> to fix the code to preferentially steal a page from a 'crashalot' process.
> 
> And at that point, what you probably want instead is a global per-UID RSS
> limit.  This looks like a job for a CKRM resource class controller rather than
> a hack to the swap code.

Not quite.
I've got one set of users that I care about their processes never dying
root, ..., and another set that I don't.

I want them to contend for real RAM as normal - it's quite acceptible to 
me for users in the second group to push root/...s web-proxy, screen 
session, processes far into slow local swap. Most of these processes 
will be not very interactive - but I don't want them to die.

If the fast (but unreliable) swap device dies - I'm quite happy for my 
firefox and mplayer processes to die - but not my window manager or 
whatever. RSS limits don't address this.

The only way I can think of to address this is to somehow segregate swap 
devices.
