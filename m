Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRCHQod>; Thu, 8 Mar 2001 11:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRCHQoO>; Thu, 8 Mar 2001 11:44:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:56784 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129272AbRCHQn5>;
	Thu, 8 Mar 2001 11:43:57 -0500
Date: Thu, 8 Mar 2001 11:43:24 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: linux-kernel@vger.kernel.org
Subject: Re: opening files in /proc, and modules
In-Reply-To: <200103081726.f28HQ0Q04099@513.holly-springs.nc.us>
Message-ID: <Pine.GSO.4.21.0103081141190.11458-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 Mar 2001, Michael Rothwell wrote:

> Figured it out -- I think. This appears to be the answer:
> 
> In struct proc_dir_entry,set the fill_inode function pointer to a
> callback to handle refcounts.
> 
> struct proc_dir_entry
> {
> ...
> void (*fill_inode)(struct inode *, int);
> ...
> };
[snip]
> ... right?  :)

Right for 2.2, wrong for 2.4. There you just set ->owner to THIS_MODULE
and forget about the whole mess with callbacks.
								Cheers,
									Al

