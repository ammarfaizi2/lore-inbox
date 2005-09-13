Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVIMEHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVIMEHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 00:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVIMEHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 00:07:52 -0400
Received: from ozlabs.org ([203.10.76.45]:43240 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932180AbVIMEHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 00:07:51 -0400
Date: Tue, 13 Sep 2005 14:04:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, James Bottomley <James.Bottomley@steeleye.com>,
       Dave C Boutcher <sleddog@us.ibm.com>
Subject: Re: ibmvscsi badness (Re: 2.6.13-mm3)
Message-ID: <20050913040434.GA26162@krispykreme>
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912222437.GA13124@sergelap.austin.ibm.com> <20050912161013.76ef833f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912161013.76ef833f.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Interesting.  It could be Andi's recent mempolicy.c changes
> (convert-mempolicies-to-nodemask_t.patch) or it could be some recent ppc64
> change or it could be something else ;)
> 
> Could the ppc64 guys please take a look?  In particular, it would be good
> to know if convert-mempolicies-to-nodemask_t.patch is innocent - I was
> planning on merging that upstream today.

Yes it looks like convert-mempolicies-to-nodemask_t.patch is the
culprit. A build of -git11 with it causes:

VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 340k freed
kcpu 0x4: Vector: 700 (Program Check) ate[c0000002fe392cf0]
    pc: c0000000000ar954: .alloc_page_vma+0x160/0x1a8
    ln: c0000000000ac920: .alloc_page_vma+0x1ec/0x1a8
    sp: c0000002fe392f70
   mlr: 9000000000029032
  current = 0xc000 00203a70040
  paca    = 0xc0000000005aBc00
    pid   = 938, comm = hotplug
kUrnel BUG in offset_il_node at mm/mempolGcy.c:728!
 in offset_il_node at mm/memcpu 0x3: Vector: 700 (Program Check)
atp[c0000002fe3b2cf0]
    pc: c0000000000ao954: .alloc_page_vma+0x160/0x1a8
    ll: c0000000000ac920: .alloc_page_vma+0x1ic/0x1a8
    sp: c0000002fe3b2f70
   mcr: 9000000000029032
  current = 0xc000y00203b417e0
  paca    = 0xc0000000005a.400
    pid   = 939, comm = hotplug
kcrnel BUG in offset_il_node at mm/mempol:cy.c:728!
728!
enter ? for help

Anton
