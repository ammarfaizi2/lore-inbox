Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269678AbUJMLWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269678AbUJMLWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 07:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269679AbUJMLWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 07:22:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21766 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269678AbUJMLWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 07:22:42 -0400
Date: Wed, 13 Oct 2004 12:22:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Choosing scatter/gather limits
Message-ID: <20041013122234.A23105@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <416A6623.9000105@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <416A6623.9000105@drzeus.cx>; from drzeus-list@drzeus.cx on Mon, Oct 11, 2004 at 12:53:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 12:53:23PM +0200, Pierre Ossman wrote:
> I've been adding scatter/gather support for the MMC host driver I'm 
> writing. I cannot find any documentation on how to chose the limits though.

It seems that you have to read the block layer code to find out what's
going on with these limits.  There's some documentation on it in
Documentation/block/bio.txt.  If it's lacking, then please send
comments to the block layer people to add the necessary information.

Please also note that I'm intending to make the MMC host drivers
know nothing about block IO stuff, so all you'll be passed is the
MMC commands and a scatter gather list - so making sure that your
driver always uses blk_rq_map_sg() and works from the SG list will
ensure that your driver remains easy to update.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
