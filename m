Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbTGLVAH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 17:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268489AbTGLVAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 17:00:07 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:58031 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S268486AbTGLVAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 17:00:03 -0400
Date: Sat, 12 Jul 2003 22:17:21 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart, nforce2, radeon and agp fastwrite
Message-ID: <20030712211721.GA10207@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
References: <3F102E8E.4030507@portrix.net> <20030712202622.GB7741@suse.de> <3F10793E.5080202@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F10793E.5080202@portrix.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 11:10:22PM +0200, Jan Dittmer wrote:
 > Forgot to mention I had to use this patchlet to get nvidia-agp to link 
 > properly.
 > 
 > Jan
 > 
 > --- linux-mm/drivers/char/agp/generic.c Thu Jul  3 15:04:06 2003
 > +++ 2.5.73-mm3/drivers/char/agp/generic.c       Wed Jul  9 10:04:34 2003
 > @@ -39,7 +39,7 @@
 > 
 >  __u32 *agp_gatt_table;
 >  int agp_memory_reserved;
 > -
 > +EXPORT_SYMBOL(agp_memory_reserved)


Girr. I'm not entirely happy about exporting that if I can help it.
It's annoying that the nvidia_insert_memory() routine is 99% the same
as the generic routine. If it could use that, we'd not have to worry
about the export.

A possible fix could be teaching the generic routine about offsets
where the table really begins in the GART. (nforce wants a 64MB GART
for a 32MB aperture, and needs to begin at some wierd offset..

Let me think a little on this one before merging that export.

	Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
