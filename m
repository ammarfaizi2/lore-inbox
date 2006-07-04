Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWGDVVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWGDVVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWGDVVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:21:14 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:63201 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751091AbWGDVVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:21:14 -0400
Message-ID: <44AADBB5.9080307@vandrovec.name>
Date: Tue, 04 Jul 2006 23:20:53 +0200
From: Petr Vandrovec <petr@vandrovec.name>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add note that lockdep is not allowed with non-GPL modules
References: <20060704202904.GA24150@vana.vc.cvut.cz> <20060704205328.GA7598@martell.zuzino.mipt.ru>
In-Reply-To: <20060704205328.GA7598@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jul 2006 21:21:12.0544 (UTC) FILETIME=[C6869600:01C69FAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Tue, Jul 04, 2006 at 10:29:04PM +0200, Petr Vandrovec wrote:
> 
>>Hi Ingo,
>>  can you add this small notice to the lockdep option ?
>>
>>Lock dependency infrastructure forces all legacy code which uses lock to now
>>depend on lockdep_init_map symbol, which is GPL-only.  It means that almost
>>no modules can work on kernel with CONFIG_LOCKDEP set.  Let's warn user about
>>that.
> 
> 
> IANIngo, but the warning is already there:
> * Proprietary module user probably already knows that major deviations from .config
>   and kernel its module is released is no-no.

Uh?  How it comes?  VMware modules work in any kernel configuration and 
architecture.  With exception of vmmon, which contains inline assembly 
for i386 & x86-64 only.  But all configs are supported.

> * Would you add similar notice to inotify help text? It also exports
>   GPL-only symbols doncha know. Would you add such notices to everything
>   exporting GPL-only symbols?

This is just nonsense.  I am not talking about using new API, I'm saying 
that API which was not GPL-only without lockdep has GPL-only portion 
with lockdep, and this GPL-only portion is needed by implementation of 
code which existed before lockdep.  To me this looks like unexpected 
change of kernel API, and as such should be documented and warned about.

>>vmmon: module license 'unspecified' taints kernel.
>>vmmon: Unknown symbol lockdep_init_map
> 
> 
>>+	 Do not enable this option if you are using non-GPL modules, or
>>+	 they will fail to load due to missing symbol lockdep_init_map.
> 
> 
> Lock validor found a bug in NVidia driver, film at 11.

I have no idea how NVidia managed to work around that problem, but 
VMware modules suddenly depend on this GPL-only symbol, although nothing 
in the module sources refers to lockdep (same sources which worked 
yesterday are being used).
					Thanks,
						Petr Vandrovec
