Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVD2TnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVD2TnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbVD2TnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:43:20 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:24018 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262907AbVD2TnN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:43:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XqUyFCHdk3Oucg/OAL5po0wNmVmMEX1iYvO+TbYMBEbfSnfr2bcggYmujBcNNA8AFxYwA5xcAG0poqK23WxkT4yd+A4VtDUgGuwZyvGwr5apz0pxo4BA7CRavQcc4cNU4NQdRnZX1374VGNWmioDyJXQJKrgf0JizDfthsAKTWQ=
Message-ID: <5ebee0d1050429124333776354@mail.gmail.com>
Date: Fri, 29 Apr 2005 15:43:10 -0400
From: Bill Jordan <woodennickel@gmail.com>
Reply-To: bjordan@infinicon.com
To: Roland Dreier <roland@topspin.com>
Subject: Re: RDMA memory registration (was: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation)
Cc: Caitlin Bestler <caitlin.bestler@gmail.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Timur Tabi <timur.tabi@ammasso.com>
In-Reply-To: <52d5sdjzup.fsf_-_@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050425135401.65376ce0.akpm@osdl.org>
	 <20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com>
	 <20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com>
	 <426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org>
	 <5ebee0d105042907265ff58a73@mail.gmail.com>
	 <469958e005042908566f177b50@mail.gmail.com>
	 <52d5sdjzup.fsf_-_@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/05, Roland Dreier <roland@topspin.com> wrote:
>   b) (maybe someday?) Add a VM_ALWAYSCOPY flag and extend mprotect()
>      with PROT_ALWAYSCOPY so processes can mark pages to be
>      pre-copied into child processes, to handle the case where only
>      half a page is registered.

Are you suggesting making the partial pages their own VMA, or marking
the entire buffer with this flag? I originally thought the entire
buffer should be copy on fork (instead of copy on write), and I
believe this is the path Mellanox was pursing with the VM_NO_COW flag.
However, if applications are registering gigs of ram, it would be very
bad to have the entire area copied on fork.

On the other hand, I've always wondered about the choice to leave
holes in the child process's address space. I would have chosen to map
the zero page instead.

-- 
Bill Jordan
InfiniCon Systems
