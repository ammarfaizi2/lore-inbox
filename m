Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSIEQJH>; Thu, 5 Sep 2002 12:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSIEQJG>; Thu, 5 Sep 2002 12:09:06 -0400
Received: from angband.namesys.com ([212.16.7.85]:24748 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S317845AbSIEQJG>; Thu, 5 Sep 2002 12:09:06 -0400
Date: Thu, 5 Sep 2002 20:13:37 +0400
From: Oleg Drokin <green@namesys.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, szepe@pinerecords.com,
       mason@suse.com, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020905201337.A4698@namesys.com>
References: <3D76A6FF.509@namesys.com> <20020904.223651.79770866.davem@redhat.com> <20020905135442.A19682@namesys.com> <200209051109.12291.shaggy@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200209051109.12291.shaggy@austin.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   I am sorry but yor mailer corrupted the message or something like that
   so I cannot understand what do you mean.

   Ah, I see now. My latest version of a patch does a cast 
   this way (yes, I noticed that problem).
#define REISERFS_LINK_MAX (nlink_t)((((nlink_t) -1) > 0)?~0:((1u<<(sizeof(nlink_t)*8-1))-1))

Bye,
    Oleg
On Thu, Sep 05, 2002 at 11:09:12AM -0500, Dave Kleikamp wrote:
> On Thursday 05 September 2002 04:54, Oleg Drokin wrote:
> 
> > +/* Find maximal number, that nlink_t can hold. GCC is able to
> > calculate this +   value at compile time, so do not worry about extra
> > CPU overhead. */ +#define REISERFS_LINK_MAX ((((nlink_t) -1) >> 0)?~0:((1u<<(sizeof(nlink_t)*8-1))-1))
> 
> Shouldn't this be:
> 
> #define REISERFS_LINK_MAX ((((nlink_t) -1) >> 0)?(nlink_t) ~0:((1u<<(sizeof(nlink_t)*8-1))-1))
> 
> if nlink_t is u16, ~0 would still be 0xffffffff (assuming 32 bits)
> -- 
> David Kleikamp
> IBM Linux Technology Center
> 
