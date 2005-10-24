Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVJXSIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVJXSIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVJXSIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:08:09 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:12287 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751222AbVJXSII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:08:08 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: new PCI quirk for Toshiba Satellite?
Date: Mon, 24 Oct 2005 11:07:45 -0700
User-Agent: KMail/1.8.91
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, bcollins@debian.org,
       Greg KH <greg@kroah.com>, scjody@steamballoon.com, gregkh@suse.de
References: <20051015185502.GA9940@plato.virtuousgeek.org> <43594BD3.9070103@s5r6.in-berlin.de> <200510241045.08494.jbarnes@virtuousgeek.org>
In-Reply-To: <200510241045.08494.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510241107.46255.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 24, 2005 10:45 am, Jesse Barnes wrote:
> Checks against the compiler defined arch are usually wrong since users
> could be cross compiling, and I'd like to avoid an ifdef altogether. 
> I think we can make the code collapse entirely by fixing linux/dmi.h. 
> If we remove the !defined(CONFIG_X86_64) check around the extern of
> dmi_check_system, all other arches will have it defined to simply
> return 0, causing gcc to remove the dead conditional in ohci1394.c.

Duh, I don't even think we have to do anything to dmi.h, it should work 
as described above as it stands now.  All we have to do is 
unconditionally add dmi.h to ohci1394.c and use the dmi stuff there; on 
x86 it'll do something, on other arches it should compile out just fine.

Jesse
