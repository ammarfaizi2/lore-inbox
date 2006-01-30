Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWA3PA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWA3PA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWA3PA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:00:29 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:47785 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932300AbWA3PA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:00:28 -0500
Message-ID: <43DE2A71.80906@sw.ru>
Date: Mon, 30 Jan 2006 18:02:09 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: Balbir Singh <balbir@in.ibm.com>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060130120318.GB9181@hasse.suse.de> <20060130143814.GA25817@in.ibm.com> <20060130145418.GF9181@hasse.suse.de>
In-Reply-To: <20060130145418.GF9181@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>We can think about optimizing this to
>>   if (!sb->sprunes)
>>	wake_up(&sb->s_wait_prunes);
>>
> 
> 
> Hardly. This is only the case when two or more shrinkers are active in
> parallel. If that was the case often, we would have seen this much more
> frequent IMHO.
But this avoids taking 2nd lock on fast path.

Kirill


