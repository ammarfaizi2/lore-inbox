Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318176AbSIFIsO>; Fri, 6 Sep 2002 04:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318194AbSIFIsO>; Fri, 6 Sep 2002 04:48:14 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:41211 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318176AbSIFIsN>; Fri, 6 Sep 2002 04:48:13 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020904.163410.36853929.davem@redhat.com> 
References: <20020904.163410.36853929.davem@redhat.com>  <200209042018.g84KI6612079@shaggy.austin.ibm.com> <1031171361.10959.179.camel@tiny> 
To: "David S. Miller" <davem@redhat.com>
Cc: mason@suse.com, shaggy@austin.ibm.com, szepe@pinerecords.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Sep 2002 09:52:24 +0100
Message-ID: <20671.1031302344@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
> >    The patch will probably cause reiserfs problems as well, we've
> >    already got people with > 32767 links on disk, going to a lower
> >    number will confuse things.
> And that means you already have reiserfs partitions that cannot be
> used on other Linux platforms.  That's pretty bad. 

Surely a file system with > 32Ki links can be _used_ on sparc, you just 
can't return a correct value in st_nlink. For directories, you could 
perhaps set st_nlink to '1', which many things will interpret as
"don't know". For files, I'm not sure -- but even just setting it to 
min(32767, real_nlink) would suffice, surely? It's inaccurate but it's 
better than the idea that the file system just cannot be mounted.

Is there a requirement to stop allowing hard links (or subdirectories) 
to be made when nlink reaches the maximum representable to user space? 
Obviously you have to do it if you're keeping an nlink count on the 
medium and you'd overflow _that_, but should we return -EMLINK even if we 
could represent the new hard link on the file system?

--
dwmw2


