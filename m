Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313562AbSDLMgC>; Fri, 12 Apr 2002 08:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSDLMgB>; Fri, 12 Apr 2002 08:36:01 -0400
Received: from ns.suse.de ([213.95.15.193]:44306 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313562AbSDLMgA>;
	Fri, 12 Apr 2002 08:36:00 -0400
Date: Fri, 12 Apr 2002 14:35:59 +0200
From: Andi Kleen <ak@suse.de>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: davem@redhat.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020412143559.A25386@wotan.suse.de>
In-Reply-To: <20020410.193045.32403941.davem@redhat.com> <20020411.154651.51706443.taka@valinux.co.jp> <20020410.234821.122842406.davem@redhat.com> <20020412.213011.45159995.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 09:30:11PM +0900, Hirokazu Takahashi wrote:
> Hi,
> 
> I wondered if regular truncate() and read() might have the same
> problem, so I tested again and again.
> And I realized it will occur on any local filesystems.
> Sometime I could get partly zero filled data instead of file contents.
> 
> I analysis this situation, read systemcall doesn't lock anything
>  -- no page lock, no semaphore lock --  while someone truncates
> files partially. 
> It will often happens in case of pagefault in copy_user() to
> copy file data to user space.
> 
> I guess if needed, it should be fixed in VFS.
 
I don't see it as a big problem and would just leave it as it is (for NFS
and local) 
Adding more locking would slow down read() a lot and there should be 
a good reason to take such a performance hit. Linux did this forever
and I don't think anybody ever reported it as a bug, so we can probably
safely assume that this behaviour (non atomic truncate) is not a problem for 
users in practice.

-Andi
