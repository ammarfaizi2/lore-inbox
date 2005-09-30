Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbVI3Uza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbVI3Uza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbVI3Uza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 16:55:30 -0400
Received: from ns1.limegroup.com ([64.48.93.2]:28428 "EHLO ns1.limegroup.com")
	by vger.kernel.org with ESMTP id S1030386AbVI3Uz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 16:55:29 -0400
Date: Fri, 30 Sep 2005 16:55:19 -0400 (EDT)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@ionlinux.tower-research.com
To: Hendrik Visage <hvjunk@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Starfire (Adaptec) kernel 2.6.13+ panics on AMD64 NFS server
In-Reply-To: <d93f04c70509301310y4bde1189wbcaef40124af6766@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0509301635020.13733@ionlinux.tower-research.com>
References: <d93f04c70509292036x269df799y7b51c5be9c3356d6@mail.gmail.com> 
 <20050929211649.69eaddee.akpm@osdl.org>  <d93f04c70509300901s3836b8afw4792d16c589b4fc4@mail.gmail.com>
  <20050930104046.4685e975.akpm@osdl.org> <d93f04c70509301310y4bde1189wbcaef40124af6766@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005, Hendrik Visage wrote:

> Anycase, here is a non-PREEMPT traceback.

Same trace, pretty much like I expected. Still, starfire must be getting 
a bad skb from the upper layers, because it gets passed __unmodified__ to 
skb_checksum_help().

Either that, or skb_checksum_help() itself got broken at some point, at 
least on 64-bit platforms.

I'll try to reproduce it over the weekend (assumming I can get an x86_64 
box set up, with a starfire inside) and see where the problem is.

> What makes this one interesting, is that in the preempt case, I had to 
> push the NFS output to get the panic, but the non-preempt case attached, 
> sorta just happened, ie. when the clients just checked on the server's 
> status :(

I'm actually surprised you got your panic from nfsd. skb_checksum_help() 
is called only when one of the fragments has length == 1, so the easiest 
way to hit it is to slowly type something into a telnet session.

Thanks,
Ion

-- 
   It is better to keep your mouth shut and be thought a fool,
             than to open it and remove all doubt.
