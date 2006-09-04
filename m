Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWIDPem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWIDPem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWIDPem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:34:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751468AbWIDPel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:34:41 -0400
Subject: Re: [PATCH 02/16] GFS2: Core locking interface
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609041108570.11217@yvahk01.tjqt.qr>
References: <1157030977.3384.786.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609010852470.25521@yvahk01.tjqt.qr>
	 <1157360497.3384.888.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609041108570.11217@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Sep 2006 16:40:01 +0100
Message-Id: <1157384401.3384.956.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-09-04 at 11:22 +0200, Jan Engelhardt wrote:
> Hi,
> 
> 
> >Unfortunately thats not possible as the struct gfs2_sbd is actually
> >changed lower down the call chain, but only in the lock_dlm module.
> 
> +void gfs2_lm_unmount(struct gfs2_sbd *sdp)
> +{
> +	if (likely(!test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
> +		gfs2_unmount_lockproto(&sdp->sd_lockstruct);
> +}
> 
> I can't follow... test_bit does not modify *sdp or sdp->sd_flags, and
> gfs2_unmount_lockproto does not either.
> 
sd_lockstruct is part of the superblock and fields in the lockstruct are
changed by (for example) fs/gfs2/locking/dlm/mount.c: gdlm_unmount() so
I don't think its valid to mark the superblock const here (despite being
a great fan of using const in general).


Steve.


