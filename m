Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRAILdc>; Tue, 9 Jan 2001 06:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbRAILdN>; Tue, 9 Jan 2001 06:33:13 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:26867 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S130024AbRAILdH>; Tue, 9 Jan 2001 06:33:07 -0500
Date: Mon, 8 Jan 2001 17:50:36 +0100
From: Andi Kleen <ak@muc.de>
To: Ben Greear <greearb@candelatech.com>
Cc: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hashed device lookup (New Benchmarks)
Message-ID: <20010108175036.A22154@fred.local>
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107042959.A14330@gruyere.muc.suse.de> <3A580B31.7998C783@candelatech.com> <20010107062744.A15198@gruyere.muc.suse.de> <3A58249F.86DD52BC@candelatech.com> <3A597665.4B68C39@candelatech.com> <200101080700.XAA10037@pizda.ninka.net> <3A59EA1F.AEAD08A6@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A59EA1F.AEAD08A6@candelatech.com>; from greearb@candelatech.com on Mon, Jan 08, 2001 at 04:23:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 04:23:41PM +0100, Ben Greear wrote:
> I don't argue that ifconfig shouldn't be fixed, but the hash speeds up

It's already fixed since months. There was one stupid algorithm, which
I was to blame for when I changed ifconfig to use a device list two years ago.
At that time I didn't think that anybody would be ever crazy enough to set up
4000 interfaces and just chosed the simplest list management. I fixed it 
when you first complained a few months ago and now the list insertion works
that the list does not need to be walked fully in the usual case.
It could be optimized more in user space, but it's probably not worth it. 

> ip by about 2X too.  Is that not useful enough?  ip seems to be implemented
> pretty efficient, so if the hash helps it significantly then maybe it
> can help other efficient programs too.  Notice that it is the system
> (ie kernel) time that stays remarkably flat with the hash + ip graph.

Just does your benchmark represent anything that real users do frequently ? 

If you really want to optimize I'm sure there are lots of areas in the kernel
where your efforts are better spent ;) [just run with a the kernel profiler on
for a few days on your box and look at all the real hot spots] 

BTW, if you just want to optimize ip link ls speed it would be probably enough
to keep a one behind cache that just caches the next member after the last
search. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
