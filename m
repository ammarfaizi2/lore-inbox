Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWBEQEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWBEQEJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 11:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWBEQEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 11:04:09 -0500
Received: from khc.piap.pl ([195.187.100.11]:12048 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750882AbWBEQEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 11:04:08 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
	<787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
	<Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
	<20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner>
	<787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
	<43E374CF.nail5CAMKAKEV@burner> <20060203155349.GA9301@voodoo>
	<20060203180421.GA57965@dspnet.fr.eu.org>
	<20060203183719.GB11241@voodoo> <m3u0bfdtm4.fsf@defiant.localdomain>
	<Pine.LNX.4.61.0602050838110.6749@yvahk01.tjqt.qr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 05 Feb 2006 17:04:04 +0100
In-Reply-To: <Pine.LNX.4.61.0602050838110.6749@yvahk01.tjqt.qr> (Jan Engelhardt's message of "Sun, 5 Feb 2006 08:40:42 +0100 (MET)")
Message-ID: <m33bixg5cb.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> I would say we all forgot to RTFM. Because O_EXCL does nothing *unless* 
> O_CREAT is specified, which probably *is not* specified in cdrecord or 
> hal.

That would be the case if the CD writter wasn't a block device.

For a block device fs/block_dev.c:

static int blkdev_open(struct inode * inode, struct file * filp)
{
...

        if (!(filp->f_flags & O_EXCL) )
                return 0;

        if (!(res = bd_claim(bdev, filp)))
                return 0;

        blkdev_put(bdev);
        return res;
-- 
Krzysztof Halasa
