Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbTDBHBU>; Wed, 2 Apr 2003 02:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbTDBHBU>; Wed, 2 Apr 2003 02:01:20 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:48395 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261805AbTDBHBT>; Wed, 2 Apr 2003 02:01:19 -0500
Date: Wed, 2 Apr 2003 08:12:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030402081243.A22213@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303311039190.5042-100000@serv> <20030331172403.GM32000@ca-server1.us.oracle.com> <1049208134.19703.12.camel@dhcp22.swansea.linux.org.uk> <b6d23r$ihn$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b6d23r$ihn$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, Apr 01, 2003 at 01:59:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 01:59:23PM -0800, H. Peter Anvin wrote:
> Or 32:32... if we have a hope for that.  Given that the bulk of the
> overhead is *already* taken in userspace I still think we should go
> all the way on this one.

Yes, having the same represantation as glibc sounds like a good idea
in general.  And the more we use struct block_device * / struct char_device *
in the kernel the less the big size actually matters.

> But yes, we need to make sure old-api
> devices get -ENXIO on open anything beyond the 8-bit minor space.

For block devices this is no problem, they register regions not majors.
For character devices that sounds the way to go, too.  I'll look into it
once I've finished by devfs API sanitizing, but if viro magically reappeared
and could post his existing patches for it this would make it even easier...

