Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbSJUWYv>; Mon, 21 Oct 2002 18:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbSJUWYV>; Mon, 21 Oct 2002 18:24:21 -0400
Received: from main.gmane.org ([80.91.224.249]:9136 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261751AbSJUWYP>;
	Mon, 21 Oct 2002 18:24:15 -0400
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: [PATCH] Retrieve configuration information from kernel
Date: Mon, 21 Oct 2002 18:31:17 -0400
Message-ID: <ap1v42$u8e$1@main.gmane.org>
References: <E183g5n-0004dC-00@lyra.fc.hp.com>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1035239362 30990 130.127.121.177 (21 Oct 2002 22:29:22 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Mon, 21 Oct 2002 22:29:22 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz wrote:

> I am including a patch that allows a user to embed kernel configuration
> in the kernel and retrieve it later either from a running kernel or from
> the kernel image file. This is an enhancement to Randy's patch that was
> discussed on LKML before and is part of -ac series kernels.
> 
> This patch provides three choices for embedding kernel configuration:
> 
> 1. Include configuration in running kernel image. This adds to the
> footprint of the running kernel but allows configuration to be retrieved
> using "cat /proc/ikconfig/config".
> 
> 2. Include configuration in kernel image file but not in the running
> kernel. This adds to the kernel image file size but not the footprint of
> running kernel. Configuration can be extracted from kernel image file
> using scripts/extract-ikconfig. This script is in principle the same as
> what Randy had written originally. I have made it little more robust and
> structured it to accomodate more than just x86 architecture.
> 
> 3. Not include kernel configuration in the running kernel or kernel
> image file.
> 
> With these three choices, users can make the appropriate tradeoff. This
> feature is especially useful for support folks who need to know the
> kernel configuration for a customer's kernel with fairly high degree of
> confidence that they are getting the right configuration. This feature
> is turned off in the default configuration.

Hi Kahlid,

I've actually been using a similar (albiet not as complex) solution based on 
a patch[1] I forward ported to 2.5 from WOLK[2].  You might want to have a 
look at it, since the nice thing about it was that the .conf file was 
compressed via gzip prior to inclusion in the kernel.  Thus the memory 
footprint was reduced as well.  Another neat attribute was the "make 
cloneconfig" command which was included in the top-level Makefile.  
Basically it would parse /proc/blah.gz and send the information directly to 
Config, generating the configuration non-interactively.  Not a big deal, 
just one less step in the scheme of things.  Otherwise, I'd say it looks 
good to me.

Cheers,
Nicholas

[1] 163_config.gz-2.4.18-pre3.patch
[2] 
http://unc.dl.sourceforge.net/sourceforge/wolk/linux-2.4.18-wolk3.6-patchset.tar.bz2


