Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWANPZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWANPZu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWANPZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:25:48 -0500
Received: from [62.38.115.213] ([62.38.115.213]:45722 "EHLO pfn3.pefnos")
	by vger.kernel.org with ESMTP id S964785AbWANPZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:25:47 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Ian Kent <raven@themaw.net>
Subject: Re: Regression in Autofs, 2.6.15-git
Date: Sat, 14 Jan 2006 17:25:26 +0200
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, hch@lst.de, linux-kernel@vger.kernel.org
References: <200601140217.56724.p_christ@hol.gr> <20060114051737.6e49dffe.akpm@osdl.org> <200601141711.06598.p_christ@hol.gr>
In-Reply-To: <200601141711.06598.p_christ@hol.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141725.28347.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 5:11 pm, P. Christeas wrote:
> Doesn't that mean that mnt==0x0004 ? Clearly wrong. I can also see from
> Christian's patch that mnt wasn't previously used, so it makes perfect
> sense for that commit to introduce the oops.
>
> I guess the problem lies in autofs4_revalidate (fs/autofs4/root.c:420), the
> nd->mnt value..
>
> I will add a silly validator (mnt>0xff) instead of (mnt) and see..
Confirmed: ((u32)mnt>0xff) discards the invalid 'mnt' value and the oops 
disappears.
That is, the autofs4 code needs some debugging :( .
