Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUBYSip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUBYSip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:38:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62982 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261540AbUBYSij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:38:39 -0500
Message-ID: <403CEBA5.5020008@zytor.com>
Date: Wed, 25 Feb 2004 10:38:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Early memory patch, revised
References: <403ADCDD.8080206@zytor.com> <m1r7wjf22s.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r7wjf22s.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> Thanks.  :)
> 
> Two little tweaks I can think of.
> 1) Can we reserve space between __bss_stop and _end for the page
>    tables and the bitmap of memory?   
>    
>    This should make it obvious that the early boot code is touching
>    that memory.
> 

The bitmap of memory, perhaps, I'll let wli speak to that one.  The page
tables shouldn't need to be fixed-sized like what you're proposing;
although the current patch doesn't make use of it, I'd like to in the
future, and this would make it impossible.

> 2) Can we export _end in setup.S so a bootloader can verify the
>    kernel + bss will fit in memory?

For what good?  Seriously... you're just pushing further into the kernel
the point where you will run completely out of memory during
initialization -- this case dynamic.

There is absolutely no use in trying to pointf*ck this.  Really.

	-hpa

