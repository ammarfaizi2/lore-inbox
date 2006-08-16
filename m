Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWHPSsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWHPSsw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWHPSsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:48:52 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:7582 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750802AbWHPSsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:48:51 -0400
Date: Wed, 16 Aug 2006 20:48:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: clowncoder <clowncoder@clowncode.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New version of ClownToolKit
Message-ID: <20060816184803.GD5852@mars.ravnborg.org>
References: <1155749588.3839.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155749588.3839.19.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:33:08PM +0200, clowncoder wrote:
> Hello,
> 
> The kernel module of the last version of the ClownToolKit has been 
> completly rewriten. It is now readable. 
> This kernel module permits the display of real-time plots for 
> bandwidth of tcp/udp connexions and for qdiscs monitoring. 
> It could be a usefull tool: http://clowncode.net 

A small nitpick about the way ou build the ekrnel module:

In mk_and_insmod you can replace:
make -C /usr/src/linux SUBDIRS=$PWD modules
with
LIBDIR=/lib/modules/`uname -r`
make -C $LIBDIR/source O=$LIBDIR/build SUBDIRS=`pwd` modules

For a normal kernel installation this will do the right thing.
source points to the kernel source and build point to the output
directory (they are often equal but not always).

$PWD is supplied by the shell, so it is better to use `pwd`.

	Sam
