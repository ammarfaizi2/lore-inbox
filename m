Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUBKWWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUBKWWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:22:40 -0500
Received: from pop.gmx.de ([213.165.64.20]:47816 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266202AbUBKWWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:22:39 -0500
X-Authenticated: #4512188
Message-ID: <402AAB2C.8050207@gmx.de>
Date: Wed, 11 Feb 2004 23:22:36 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4
References: <20040115225948.6b994a48.akpm@osdl.org> <4007B03C.4090106@gmx.de>            <400EC908.4020801@gmx.de> <200401211920.i0LJKZ2a003504@turing-police.cc.vt.edu>
In-Reply-To: <200401211920.i0LJKZ2a003504@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 21 Jan 2004 19:46:32 +0100, "Prakash K. Cheemplavam" said:
> 
>>Ok, here is the stack backtrace:
>>
>>I hope it helps, otherwise I could try compiling in frame-pointers. (I 
>>used another logger to get this...)
>>
>>Is it nvidia driver doing something bad (which earlier kernels didn't do)?
>>
>>Jan 21 19:25:39 tachyon Badness in pci_find_subsys at 
>>drivers/pci/search.c:132
>>Jan 21 19:25:39 tachyon Call Trace:
>>Jan 21 19:25:39 tachyon [<c027a7f8>] pci_find_subsys+0xe8/0xf0
>>Jan 21 19:25:39 tachyon [<c027a82f>] pci_find_device+0x2f/0x40
>>Jan 21 19:25:39 tachyon [<c027a6e8>] pci_find_slot+0x28/0x50
> 
> 
> If this is the NVidia graphics driver, it's been doing it at least since 2.5.6something,
> at least that I've seen.  It's basically calling pci_find_slot in an interrupt context,
> which ends up calling pci_find_subsys which complains about it.  One possible
> solution would be for the code to be changed to call pci_find_slot during module
> initialization and save the return value, and use that instead.  Yes, I know this
> prevents hotplugging.  Who hotplugs graphics cards? ;)

Could you advise me how to make a dirty hack to get this going? Once 
again I am back to 2.6.1-rc1 kernel, which seems to be the last one 
stable for me. 2.6.3-rc1-mm1 locked up quite fast..

Perhaps it would also help to test the snapshots between rc1 and rc2 to 
find out which patch borked for me... I see 6 bk versions. Are these 
just incremental patches?

Prakash

