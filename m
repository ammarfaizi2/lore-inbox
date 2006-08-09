Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWHITW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWHITW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWHITW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:22:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:43682 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751298AbWHITW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:22:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=swpe6x7R5Zv3SepPJJPiYnXP74Cn6ELmrpPwVyv4+eir+TMLxHIXkJ72Rme6SyUAk5OmH3JRPH/UzCoh6yXW/WxykuvXAq9qg5yfBnwDVt6oJznnnLXj9Uvsvt3XMWj+SI6/SLg8QJ6vnY6dYvTYsUOAfCL3HsOccLDi3hcfB8c=
Message-ID: <84144f020608091213u4bbb1d07xe8486a4549208016@mail.gmail.com>
Date: Wed, 9 Aug 2006 22:13:21 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: [RFC/PATCH] revoke/frevoke system calls V2
Cc: "Edgar Toernig" <froese@gmx.de>,
       "Chase Venters" <chase.venters@clientec.com>,
       "Pavel Machek" <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
In-Reply-To: <1155148605.5729.251.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
	 <Pine.LNX.4.64.0608071720510.29055@turbotaz.ourhouse>
	 <1155039338.5729.21.camel@localhost.localdomain>
	 <20060809104159.1f1737d3.froese@gmx.de>
	 <1155119999.5729.141.camel@localhost.localdomain>
	 <20060809200010.2404895a.froese@gmx.de>
	 <1155148605.5729.251.camel@localhost.localdomain>
X-Google-Sender-Auth: ad5ef2d334706051
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-09 am 20:00 +0200, ysgrifennodd Edgar Toernig:
> > But anyway, correct me if I'm wrong, revoke (V2) not simply removes the
> > pages from the mmaped area as truncating does (the vma stays);  revoke
> > seems to completely remove the vma which is clearly a security bug.
> > Future mappings may silently get mapped into the area of the revoked
> > file without the app noticing it.  It may then hand out data of the new
> > file still thinking it's sending the old one.

On 8/9/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> I agree with that point 100%.

Agreed also. I already had a version that simply replaced the ->nopage
method of vma_ops but took what forced unmount patch had to get proper
->close dealings. But I completely agree that sane revocation should
allow close(2) and munmap(2) on the revoked fd and shared mapping.
I'll put them on my todo and in the meanwhile, you can find the latest
patches here: http://www.kernel.org/pub/linux/kernel/people/penberg/patches/revoke/

Thanks for taking the time to review the patch!

                                     Pekka
