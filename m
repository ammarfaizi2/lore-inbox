Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSH0Nv0>; Tue, 27 Aug 2002 09:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSH0Nv0>; Tue, 27 Aug 2002 09:51:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6868 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316199AbSH0NvZ>;
	Tue, 27 Aug 2002 09:51:25 -0400
Date: Tue, 27 Aug 2002 19:28:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, davej@suse.de, andrea@suse.de,
       paul.mckenney@us.ibm.com
Subject: Re: [BKPATCH] Read-Copy Update 2.5
Message-ID: <20020827192855.A2391@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020827022239.C31269@in.ibm.com> <20020826193708.0C64C2C07B@lists.samba.org> <20020827114152.A2072@in.ibm.com> <20020826.231157.10296323.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020826.231157.10296323.davem@redhat.com>; from davem@redhat.com on Mon, Aug 26, 2002 at 11:11:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 11:11:57PM -0700, David S. Miller wrote:
> 
> I think it gets both static and non-static wrong.

Is this problem specific to certain versions of 2.95 gcc ?

For "static DEFINE_PER_CPU(atomic_t, fake_struct);", I get this
with gcc 2.95.4 -

.section        .percpu
        .align 4
        .type    fake_struct__per_cpu,@object
        .size    fake_struct__per_cpu,4
fake_struct__per_cpu:
        .zero   4
        .ident  "GCC: (GNU) 2.95.4 20011002 (Debian prerelease)"

It seems to be in .percpu section. I can't go back to the gcc that gave 
us problems at the moment.

> 
> Why don't we just specify that DEFINE_PER_CPU()'s must
> have explicit initializers then we never need to think
> about this ever again.

Like DEFINE_PER_CPU(type, var, initializer) ?
For now, I will remain paranoic and keep the initializers.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
