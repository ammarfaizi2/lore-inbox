Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285260AbRLMXaT>; Thu, 13 Dec 2001 18:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285261AbRLMXaJ>; Thu, 13 Dec 2001 18:30:09 -0500
Received: from ns.suse.de ([213.95.15.193]:42247 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285260AbRLMXaC>;
	Thu, 13 Dec 2001 18:30:02 -0500
Date: Fri, 14 Dec 2001 00:29:57 +0100
From: Andi Kleen <ak@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        ak@suse.de
Subject: Re: optimize DNAME_INLINE_LEN
Message-ID: <20011214002957.A24984@wotan.suse.de>
In-Reply-To: <3C192A37.4547D2A7@colorfullife.com> <20011213160706.E940@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213160706.E940@lynx.no>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 04:07:06PM -0700, Andreas Dilger wrote:
> Alternately (also ugly) you could just define struct dentry the as now,
> but have a fixed size declaration for d_iname, like:
> 
> #define DNAME_INLINE_MIN 16
> 
> 	unsigned char d_iname[DNAME_INLINE_MIN];
                   Using [0] here would also work 
and fixing other code to add DNAME_INLINE_MIN as needed. Unfortunately
this "fixing other code" would likely prevent the patch going into 2.4,
which would be bad. 

#define d_... has a similar problem => the potential to break previously
compiling source code.

Probably just using an compiler #ifdef is best, and perhaps doing it 
cleanly (with using d_iname[0]) on 2.5.


-Andi

P.S.: I originally picked the 16 number and it was totally arbitary, so 
an increase on the fallback to 20-30 would be likely ok. 
