Return-Path: <linux-kernel-owner+w=401wt.eu-S1753176AbWLQXDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbWLQXDY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 18:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbWLQXDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 18:03:24 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:50474 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbWLQXDX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 18:03:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix sparsemem on Cell
Date: Mon, 18 Dec 2006 00:02:09 +0100
User-Agent: KMail/1.9.5
Cc: Dave Hansen <haveblue@us.ibm.com>, cbe-oss-dev@ozlabs.org, akpm@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, hch@infradead.org,
       paulus@samba.org, mkravetz@us.ibm.com, gone@us.ibm.com
References: <20061215171411.E3EE01AD@localhost.localdomain>
In-Reply-To: <20061215171411.E3EE01AD@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612180002.11079.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 December 2006 18:14, Dave Hansen wrote:
> +       if (system_state >= SYSTEM_RUNNING)
> +               return 1;
> +       if (!early_pfn_valid(pfn))
> +               return 0;
> +       if (!early_pfn_in_nid(pfn, nid))
> +               return 0;

I haven't tried it, but I assume this is still wrong. On cell,
we didn't actually hit the case where the init sections have
been overwritten, since we call __add_pages from an initcall.

However, the pages we add are not part of the early_node_map,
so early_pfn_in_nid() returns a bogus result, causing some
page structs not to get initialized. I believe your patch
is going in the right direction, but it does not solve the
bug we have...

	Arnd <><
