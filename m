Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267747AbSLGLT3>; Sat, 7 Dec 2002 06:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbSLGLT3>; Sat, 7 Dec 2002 06:19:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32017 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267747AbSLGLT3>; Sat, 7 Dec 2002 06:19:29 -0500
Date: Sat, 7 Dec 2002 11:26:57 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Gibson <david@gibson.dropbear.id.au>,
       "Adam J. Richter" <adam@yggdrasil.com>, James.Bottomley@steeleye.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021207112657.A18207@flint.arm.linux.org.uk>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	James.Bottomley@steeleye.com, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, miles@gnu.org
References: <200212060714.XAA06006@adam.yggdrasil.com> <20021207094530.GB22230@zax.zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021207094530.GB22230@zax.zax>; from david@gibson.dropbear.id.au on Sat, Dec 07, 2002 at 08:45:30PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2002 at 08:45:30PM +1100, David Gibson wrote:
> Actually, no, since my idea was to remove the "consistent_alloc()"
> path from the driver entirely - leaving only the map/sync approach.
> That gives a result which is correct everywhere (afaict) but (as
> you've since pointed out) will perform poorly on platforms where the
> map/sync operations are expensive.

As I've also pointed out in the past couple of days, doing this will
mean that you then need to teach the drivers to align structures to
cache line boundaries.  Otherwise, you _will_ get into a situation
where you _will_ loose data.

One such illustration of this is the tulip driver, with an array of
16-byte control/status blocks on a machine with a 32-byte cache line
size.

I would rather keep the consistent_alloc() approach for allocating
consistent memory, and align structures as they see fit, rather than
having to teach the drivers to align appropriately.  And you can be
damned sure that driver writers are _not_ going to get the alignment
right.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

