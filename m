Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTJJQ11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbTJJQ11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:27:27 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:23891 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263002AbTJJQ1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:27:19 -0400
Date: Fri, 10 Oct 2003 17:27:11 +0100
From: Dave Jones <davej@redhat.com>
To: Thom Borton <borton@phys.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA CD-ROM does not work
Message-ID: <20031010162710.GF25856@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thom Borton <borton@phys.ethz.ch>, linux-kernel@vger.kernel.org
References: <200310101652.53796.borton@phys.ethz.ch> <20031010150916.GA32600@redhat.com> <200310101744.30827.borton@phys.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310101744.30827.borton@phys.ethz.ch>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 05:44:30PM +0200, Thom Borton wrote:
 > 
 > Thanks a lot, I tried the parameters 
 > 	ide1=0x386,0x180 pci=off
 > and it did not work. pci=off seems to have broken quite a lot (fb, 
 > jogdial, ...). Just leaving it away and just having ide1=0x386,0x180 
 > didn't help the CD-ROM drive either.

Something else that needs fixing is pcmcia-cs has its exclude list
for the RadeonIGP bug set way too wide.
/etc/pcmcia/config.opts has..

exclude port 0x380-0x3ff

Which is bad news, as the Vaio wants port 0x386. The actual ports that
cause problems are 0x3b0->0x3bb and 0x3d3

After fixing this, it detects the drive, but hangs when you try and
mount it.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
