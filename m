Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbUCKXhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUCKXhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:37:43 -0500
Received: from colin2.muc.de ([193.149.48.15]:36100 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261848AbUCKXhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:37:22 -0500
Date: 12 Mar 2004 00:37:20 +0100
Date: Fri, 12 Mar 2004 00:37:20 +0100
From: Andi Kleen <ak@muc.de>
To: Joe Thornber <thornber@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Mickael Marchand <marchand@kde.org>,
       linux-kernel@vger.kernel.org, dm@uk.sistina.com
Subject: Re: 2.6.4-mm1
Message-ID: <20040311233720.GB46488@colin2.muc.de>
References: <1ysXv-wm-11@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it> <m3hdwnawfi.fsf@averell.firstfloor.org> <200403111445.35075.marchand@kde.org> <20040311144829.GA22284@colin2.muc.de> <20040311214354.GM18345@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311214354.GM18345@reti>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 09:43:54PM +0000, Joe Thornber wrote:
> On Thu, Mar 11, 2004 at 03:48:29PM +0100, Andi Kleen wrote:
> > Maybe they have broken data structures again, most likely
> > because of different long long alignment. A lot of people
> > who attempt to design data structures that don't need translation
> > get that wrong unfortunately.
> 
> I'd thought we'd been careful about this.  You're suggesting that the
> size of this structure has changed between kernel versions ?!
> 
> struct dm_ioctl {
>         uint32_t version[3];
>         uint32_t data_size;
> 
>         uint32_t data_start;
> 
>         uint32_t target_count;
>         int32_t open_count;
>         uint32_t flags;
>         uint32_t event_nr;
>         uint32_t padding;
> 
>         uint64_t dev;
> 
>         char name[DM_NAME_LEN];
>         char uuid[DM_UUID_LEN];

Are DM_NAME_LEN and DM_UUID_LEN not both a multiple of 8?

> };

There are more structures here, right?

If yes, that's the problem.

-Andi
