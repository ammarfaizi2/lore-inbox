Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbSI3AYW>; Sun, 29 Sep 2002 20:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261876AbSI3AYW>; Sun, 29 Sep 2002 20:24:22 -0400
Received: from zero.aec.at ([193.170.194.10]:13834 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261875AbSI3AYV>;
	Sun, 29 Sep 2002 20:24:21 -0400
Date: Mon, 30 Sep 2002 02:29:15 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, ak@muc.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20020930002915.GA2805@averell>
References: <20020929152731.GA10631@averell> <20020929182643.C8564@infradead.org> <20020929.171110.04716295.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929.171110.04716295.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 02:11:10AM +0200, David S. Miller wrote:
>    From: Christoph Hellwig <hch@infradead.org>
>    Date: Sun, 29 Sep 2002 18:26:43 +0100
>    
>    BTW, do you have any stats on the better optimization?
> 
> Unlikely since we disable strict aliasing on the gcc command
> line which is why I think this suggested __malloc thing is
> utterly pointless.

My understanding of it is: Please correct me if I'm wrong [i haven't 
verified this with tree dumps]

-fno-strict-aliasing tells each pointer that it can alias with everything
else (puts it in alias set 0)

__attribute__((malloc)) overwrites this so that the compiler knows that
this particular pointer that has been returned  (puts it into an own
alias set again and overwrites the -fno-strict-aliasing default) 

Another way to overwrite it would be restrict, but nobody uses that
currently. May make sense to add it to compile compiler version checked
macros too, so that it can be safely used.

Then it would be actually possible to write functions that get optimized
this way. I'm aware that the aliasing stuff mostly helps with array walks
and loops, which are not that common in the kernel, but it could be still
useful.

-Andi
