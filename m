Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313781AbSDPRnS>; Tue, 16 Apr 2002 13:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313784AbSDPRnR>; Tue, 16 Apr 2002 13:43:17 -0400
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:44247 "EHLO
	mel-rti20.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313781AbSDPRnQ>; Tue, 16 Apr 2002 13:43:16 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>, <david.lang@digitalinsight.com>
Cc: <vojtech@suse.cz>, <dalecki@evision-ventures.com>,
        <rgooch@ras.ucalgary.ca>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
Date: Tue, 16 Apr 2002 18:40:22 +0100
Message-Id: <20020416174022.25545@smtp.wanadoo.fr>
In-Reply-To: <20020416.100610.115916272.davem@redhat.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I could be wrong, it's a 2.1.x kernel that they started with. I thought
>   that was around the time the fix went in.
>   
>Again, I did the fix 6 years ago, thats pre-2.0.x days
>
>EXT2 has been little-endian only with proper byte-swapping support
>across all architectures, since that time.

My understanding it that Tivo behaves like some Amiga's here
and has broken swapping of the IDE bus itself, not the ext2
filesystem.

On PPC, we still have some historical horrible macros redefinitions
in asm/ide.h to let APUS (PPC Amiga) deal with these.

Now, the problem of dealing with DMA along with the swapping is
something scary. I beleive the sanest solution that won't please
affected people is to _not_ support DMA on these broken HW ;)

Another way would be, for such broken controllers, to break the
request into 1 page max requests and let them all go through a
bounce buffer.

Ben.


