Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTFKItC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 04:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTFKItB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 04:49:01 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:7442 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264235AbTFKItA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 04:49:00 -0400
Date: Wed, 11 Jun 2003 10:00:01 +0100
From: Joe Thornber <thornber@sistina.com>
To: Christophe Saout <christophe@saout.de>
Cc: Shane Shrybman <shrybman@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70-mm7
Message-ID: <20030611090001.GB2499@fib011235813.fsnet.co.uk>
References: <1055286765.2371.4.camel@mars.goatskin.org> <1055288033.27439.4.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055288033.27439.4.camel@chtephan.cs.pocnet.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe,

On Wed, Jun 11, 2003 at 01:33:53AM +0200, Christophe Saout wrote:
> Ok, I think I found the problem.

You are quite right.  I am an idiot.  I think the simplest way to fix
this is stop trying to overload the 'minor' argument to dm_create, and
instead have a seperate dm_create_with_minor function call.

ie.

int dm_create(struct dm_table *table, struct mapped_device **md);
int dm_create_with_minor(unsigned int minor, struct dm_table *table,
			 struct mapped_device **md);

I'm testing a patch for this now (with LVM this time, not just
dmsetup), and will post to the list in the next hour.

Sorry for the inconvenience,

- Joe
