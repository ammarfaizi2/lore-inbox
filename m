Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262763AbTDBUrf>; Wed, 2 Apr 2003 15:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262940AbTDBUrf>; Wed, 2 Apr 2003 15:47:35 -0500
Received: from havoc.daloft.com ([64.213.145.173]:27831 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262763AbTDBUre>;
	Wed, 2 Apr 2003 15:47:34 -0500
Date: Wed, 2 Apr 2003 15:58:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Dennis Cook <cook@sandgate.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Deactivating TCP checksumming
Message-ID: <20030402205855.GA4125@gtf.org>
References: <F91mkXMUIhAumscmKC00000f517@hotmail.com> <20030401122824.GY29167@mea-ext.zmailer.org> <b6fda2$oec$1@main.gmane.org> <20030402203653.GA2503@gtf.org> <b6fi8m$j4g$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6fi8m$j4g$1@main.gmane.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 03:47:35PM -0500, Dennis Cook wrote:
> What I was looking for is a general capability to keep the SW transport
> stack from
> computing outgoing TCP/UDP/IP checksums so that the HW can be allowed to do
> it,
> similar to Windows checksum offload capability.

If you are not using sendfile(2), it is _more expensive_ to offload
checksums, because we already checksum and copy at the same time.

Hardware checksum offload is only a win when a copy is eliminated.

Therefore, _always_ offloading checksum is actually slower in some
cases, because of the unneeded additional HW csum setup that would be
performed.

	Jeff


