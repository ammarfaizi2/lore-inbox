Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbUK0RRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUK0RRF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 12:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbUK0RQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 12:16:08 -0500
Received: from gprs214-89.eurotel.cz ([160.218.214.89]:49793 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261269AbUK0ROT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 12:14:19 -0500
Date: Sat, 27 Nov 2004 18:13:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rik van Riel <riel@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org, torvalds@osdl.org,
       hbryan@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041127171318.GA1319@elf.ucw.cz>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org> <E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu> <20041118130601.6ee8bd97.akpm@osdl.org> <E1CV6vf-0006q1-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.61.0411271200580.12575@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411271200580.12575@chimarrao.boston.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >The solution I'm thinking is along the lines of accounting the number
> >of writable pages assigned to FUSE filesystems.  Limiting this should
> >solve the deadlock problem.  This would only impact performance for
> >shared writable mappings, which are rare anyway.
> 
> Note that NFS, and any filesystems on iSCSI or g/e/ndb block
> devices have the exact same problem.  To explain why this is
> the case, lets start with the VM allocation and pageout
> thresholds:
> 
>   pages_min ------------------
> 
>  GFP_ATOMIC ------------------
> 
> PF_MEMALLOC ------------------
> 
> 	  0 ------------------
> 
> When writing out a dirty page, the pageout code is allowed
> to allocate network buffers down to the PF_MEMALLOC boundary.
> 
> However, when receiving the ACK network packets from the server,
> the network stack is only allowed to allocate memory down to the
> GFP_ATOMIC watermark.

Ouch... Shame on me, I never realized that this is a problem. I knew
that swapping over nbd does not work, but I did not realize that
writeout is as critical as swapping...

:-(. This means that read/write nbd is pretty bad idea. I wonder why
it is not broken for people? Probably noone uses so big ammount of
data over nbd...

Can you describe that solution? You can do it anonymously if you want
to ;-)))).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
