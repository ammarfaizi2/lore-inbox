Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752161AbWCJHNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbWCJHNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWCJHNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:13:16 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:23986 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751899AbWCJHNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:13:15 -0500
Date: Fri, 10 Mar 2006 16:13:02 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH: 000/017] (RFC)Memory hotplug for new nodes v.3.
Cc: tony.luck@intel.com, ak@suse.de, jschopp@austin.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <20060309040021.3cf64e4b.akpm@osdl.org>
References: <20060308212316.0022.Y-GOTO@jp.fujitsu.com> <20060309040021.3cf64e4b.akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060310145025.CA6F.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment.
I'm very glad. :-)

> Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> >
> > I'll post newest patches for memory hotadd with pgdat allocation as V3.
> >  There are many changes to make more common code.
> 
> General comments:
> 
> - Thanks for working against -mm.  It can be a bit of a pain, but it
>   eases staging and integration later on.
> 
> - Please review all the code to check that all those functions which can
>   be made static are indeed made static.  I see quite a few global
>   functions there.
> - Make sure that all functions which can be tagged __meminit are so tagged.
> 
> - It would be useful to build a CONFIG_MEMORY_HOTPLUG=n kernel both with
>   and without the patchsets and to publish and maintain the increase in
>   code size.  Ideally that increase will be zero.  Probably it won't be,
>   and it'd be nice to understand why, and to minimise it.

Ok. I'll check and fix it.

> 
> - Arch issues:
> 
>   - Which architectures is this patchset aimed at and tested on?

      IA64.
      At least, Fujitsu is making this style hot-add feature
      on ia64 box which is named as PrimeQuest.
      (SGI or HP might wait it.)

>   - Which other architectures might be able to use this code in the
>     future?  Because we should ask the maintainers of those other
>     architectures to take a look at the changes.

      I heard from Andi-san that x86-64 will need this.
      And ppc64 might use some of my patch.

      It depends on ....
         - There is Numa box on its architecture.
         - One node of NUMA will be hot-added.

> - What locking does node hot-add use?  There are quite a few places in
>   the kernel which cheerfully iterate across node lists while assuming that
>   they won't change.  The usage of stop_machine_run() is supposed to cover
>   all that, I assume?

    If my understanding is correct, there is 2 critical point.
      - One is zonelist update, indeed. Stop_machine_run() can
        cover it.
      - Another is node_online_map and NODE_DATA().
        If node_online_map is onlined before that 
        NODE_DATA() is updated, or before that pgdat is initialized,
        kernel might touch uninitialized pgdat.
        So, node_set_online() is called at final point. 
    
    The old kernel had pgdat->next link list, it was also critial point
    for hot-add. But current -mm remove it. So, it is not issue now. :-)

Thanks.

-- 
Yasunori Goto 


