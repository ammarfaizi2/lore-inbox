Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbTDQPJJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTDQPJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:09:08 -0400
Received: from colin.muc.de ([193.149.48.1]:42507 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id S261694AbTDQPJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:09:05 -0400
Message-ID: <20030417172021.41103@colin.muc.de>
Date: Thu, 17 Apr 2003 17:20:21 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, willy@debian.org, ak@muc.de, linux-kernel@vger.kernel.org,
       anton@samba.org, schwidefsky@de.ibm.com, davidm@hpl.hp.com,
       matthew@wil.cx, ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
References: <20030416133539.0ac01968.akpm@digeo.com> <20030416212651.GF1505@parcelfarce.linux.theplanet.co.uk> <20030416144311.46f32253.akpm@digeo.com> <20030416.144035.130217416.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <20030416.144035.130217416.davem@redhat.com>; from David S. Miller on Wed, Apr 16, 2003 at 11:40:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 11:40:35PM +0200, David S. Miller wrote:
>    From: Andrew Morton <akpm@digeo.com>
>    Date: Wed, 16 Apr 2003 14:43:11 -0700
>    
>    Well are we sure that the `flags' and `count' fields will always fall into
>    the same 256-byte range?  Wouldn't it subtly break if sizeof(struct page)
>    became not a multiple of eight?  Will the compiler pad it out anyway?
> 
> As long as there is a long or pointer member, the structure
> will be required to be 8 byte or better aligned.

Yes that should be a safe assumption. mem_map will be always page aligned
and it should be a multiple of a power of 8. That makes it impossible for it
to cross a cache line.

-Andi
