Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946713AbWKAJEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946713AbWKAJEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946711AbWKAJEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:04:22 -0500
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:18566 "EHLO sMtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1423959AbWKAJEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:04:20 -0500
Date: Wed, 01 Nov 2006 10:04:20 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [RFC, PATCH] dont insert sockets/pipes dentries into
 dentry_hashtable.
In-reply-to: <20061101083811.GS29920@ftp.linux.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <45486314.3020300@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <20061025084726.GE18364@nuim.ie>
 <20061025.230615.92585270.davem@davemloft.net>
 <200610311948.48970.dada1@cosmosbay.com>
 <20061031.231954.23010447.davem@davemloft.net>
 <454858F2.5020206@cosmosbay.com> <20061101083811.GS29920@ftp.linux.org.uk>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro a écrit :
> On Wed, Nov 01, 2006 at 09:21:06AM +0100, Eric Dumazet wrote:
> 
>> And " (deleted)" is correctly added to deleted files.
> 
> The hell it will.
> 
> touch a
> touch b
> exec 5<a
> mv b a
> ls -l /proc/$$/fd/5
> 
> With your patch and without it, please.

Yes I will do, thanks.

> 
> PS: getting rid of socket dentries is a bad idea with the capital "Fuck, No".
> For those who want to see where does that path lead and are attracted to
> trainwrecks in general I can recommend *BSD socket handling.  They have
> paid quite painfully for lack of proper vnodes.  It's simply not worth
> the resulting trouble.

I have one server with one million sockets, wasting 210 MB of ram for dentries 
that are only used when some guy does some /proc/$pid/fd work

Socket hot path already dont use anymore dentries, thanks to file->private_data

Eric

