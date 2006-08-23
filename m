Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWHWORL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWHWORL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWHWORL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:17:11 -0400
Received: from stinky.trash.net ([213.144.137.162]:63990 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S964894AbWHWORK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:17:10 -0400
Message-ID: <44EC6360.9070109@trash.net>
Date: Wed, 23 Aug 2006 16:17:04 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
       akpm@osdl.org
Subject: Re: call panic if nl_table allocation fails
References: <20060823113740.GA7834@miraclelinux.com> <Pine.LNX.4.64.0608231003340.3198@d.namei>
In-Reply-To: <Pine.LNX.4.64.0608231003340.3198@d.namei>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Wed, 23 Aug 2006, Akinobu Mita wrote:
> 
> 
>>This patch makes crash happen if initialization of nl_table fails
>>in initcalls. It is better than getting use after free crash later.
> 
> 
>> 	nl_table = kcalloc(MAX_LINKS, sizeof(*nl_table), GFP_KERNEL);
> 
> 
> Perhaps it'd be better to declare this as an array rather than allocating 
> it at runtime.

That would still leave the MAX_LINKS allocations for the pid hashes
which need to be allocated because they are dynamically sized. We
could delay the pid hash allocations until the first bind happens
of course, but I doubt it would be worth it since they start with
just a single bucket.

