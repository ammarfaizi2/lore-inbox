Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261754AbTCUVIW>; Fri, 21 Mar 2003 16:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbTCUVHV>; Fri, 21 Mar 2003 16:07:21 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:23559 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261403AbTCUVGW>; Fri, 21 Mar 2003 16:06:22 -0500
Date: Fri, 21 Mar 2003 21:17:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Message-ID: <20030321211724.A10572@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
References: <200303212110.NAA07849@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303212110.NAA07849@adam.yggdrasil.com>; from adam@yggdrasil.com on Fri, Mar 21, 2003 at 01:10:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 01:10:10PM -0800, Adam J. Richter wrote:
> 	I'm thinking about removing all of the capability raising code
> from devfs and just having the pty code raise the capabilities
> explicitly if allocating and releasing a pseudo-terminal are really
> the only places that ever need it.

My plan is to rip out UNIX98 pty handling copletly out of devfs instead.
We already have a lean, small filesystem exactly for that purpose and
it adds lots of unessecary cruft to devfs (DEVFS_FL_CURRENT_OWNER and
DEVFS_FL_WAIT to be exact).  Afterwards devfs would only create /dev/pts/
(and /dev/pty/ as devfs renamed it IIRC) and devfs users would have to
mount devpts aswell.

