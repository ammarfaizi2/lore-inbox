Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318077AbSFTAoU>; Wed, 19 Jun 2002 20:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318078AbSFTAoT>; Wed, 19 Jun 2002 20:44:19 -0400
Received: from holomorphy.com ([66.224.33.161]:23740 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318077AbSFTAoS>;
	Wed, 19 Jun 2002 20:44:18 -0400
Date: Wed, 19 Jun 2002 17:43:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.23 mpage io vs queue_max_sectors
Message-ID: <20020620004351.GR22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20020620002105.GL25360@holomorphy.com> <3D112401.6975E890@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D112401.6975E890@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> This has been haunting me for a while on a 4 cpu Sequent S-quad with
>> 4GB of RAM, and a tray of 12 9GB DCHS09X's attached to a QLogicISP1020.
>> People keep saying "hands off" ... so here I am passing the buck.
>> Kernel BUG at ll_rw_blk.c:1639

On Wed, Jun 19, 2002 at 05:38:25PM -0700, Andrew Morton wrote:
> This is happening because we have BIO_MAX_SIZE = 64k,
> but that particular driver doesn't like requests which are
> that big.

Well, I'm not sure what the driver's doing (or not doing) but
this check is on q->max_sectors...

On Wed, Jun 19, 2002 at 05:38:25PM -0700, Andrew Morton wrote:
> This is the issuewhich Adam, Jens and I have been discussing.
> Looks like the preferred solution is an add_page_to_bio() API
> in the block layer.
> But it's not there yet, so in the short-term, please just do
> -#define MPAGE_BIO_MAX_SIZE BIO_MAX_SIZE
> +#define MPAGE_BIO_MAX_SIZE 16384
> in fs/mpage.c

Hmm, q->max_sectors is 64 in my case (and 96 was fed to the queue) so
I'm not convinced I have to cripple it entirely, I'll go with 32K.


Cheers,
Bill
