Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268791AbUHZMqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268791AbUHZMqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268884AbUHZMnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:43:45 -0400
Received: from verein.lst.de ([213.95.11.210]:21462 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268733AbUHZMl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:41:26 -0400
Date: Thu, 26 Aug 2004 14:41:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@lst.de>, Alex Zarochentsev <zam@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826124119.GA431@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Hans Reiser <reiser@namesys.com>,
	Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	Linus Torvalds <torvalds@osdl.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com> <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412DA2CF.2030204@namesys.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:43:59AM -0700, Hans Reiser wrote:
> >Again, O_DIRECTORY was added to solve a real-world race, not just for
> >the sake of it. 
> >
> Can you supply more details and we will try to reply concretely?  Thanks.

It's really userland programming 101 :)

 you need to fstat after open to really check that no one swtiched the
 path below you to a fifo or device, O_DIRECTORY gets that directly in
 the open call, with the additional benefit of making sure you don't
 get any of the sideeffects at all that would happen if you're opening
 a device file.

 the current reiser4 semantics break that and as soon as you're having a
 world-writeable (e.g. /tmp) dir on it and someone is doing an opendir
 on it he's lost.

