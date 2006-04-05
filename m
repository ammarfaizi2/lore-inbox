Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWDEAOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWDEAOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWDEAOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:14:33 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:56432 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750954AbWDEAOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:14:32 -0400
X-IronPort-AV: i="4.04,88,1144047600"; 
   d="scan'208"; a="266645765:sNHT35265452"
To: "David S. Miller" <davem@davemloft.net>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       openib-general@openib.org, bunk@stusta.de, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, rdunlap@xenotime.net,
       davej@redhat.com, chuckw@quantumlinux.com, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, mst@mellanox.co.il,
       rolandd@cisco.com
Subject: Re: [patch 11/26] IPOB: Move destructor from neigh->ops to neigh_param
X-Message-Flag: Warning: May contain useful information
References: <20060404235634.696852000@quad.kroah.org>
	<20060404235927.GA27049@kroah.com> <20060405000030.GL27049@kroah.com>
	<20060404.170720.61536177.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 04 Apr 2006 17:14:27 -0700
In-Reply-To: <20060404.170720.61536177.davem@davemloft.net> (David S. Miller's message of "Tue, 04 Apr 2006 17:07:20 -0700 (PDT)")
Message-ID: <adar74cnajg.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Apr 2006 00:14:28.0523 (UTC) FILETIME=[E76BD7B0:01C65845]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Major NAK.

    David> This does not fix a bug, it is merely and API change that
    David> the inifiniband folks want for some of their infrastructure.

It definitely does fix a bug: without the change, because
ops->destructor is shared (possibly with other net devices), IPoIB
ops->can't set it or clear it safely.  I don't have exact details at
hand but this was definitely causing panics for people.

    David> Furthermore, this version of the patch here will break the
    David> build of ATM.

I'll admit I haven't tested but it looks OK to me -- it seems to have
the required chunk in clip.c.

I'm not going to fight too hard for it (I'll let Michael champion it
if he really cares), but I think this is a legitimate -stable patch:
it fixes a panic that real users are seeing.

 - R.
