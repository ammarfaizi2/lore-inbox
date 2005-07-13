Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbVGMCQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbVGMCQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 22:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVGMCQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 22:16:51 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:1160 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262825AbVGMCQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 22:16:50 -0400
X-IronPort-AV: i="3.94,192,1118034000"; 
   d="scan'208"; a="265591444:sNHT16959324"
Date: Tue, 12 Jul 2005 21:16:48 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 22/82] remove linux/version.h from drivers/message/fus ion
Message-ID: <20050713021648.GA23118@lists.us.dell.com>
References: <91888D455306F94EBD4D168954A9457C030A908F@nacos172.co.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91888D455306F94EBD4D168954A9457C030A908F@nacos172.co.lsil.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, I have to have a similar compat file for the IPMI drivers
backported onto RHEL3, RHEL4, and SLES9.  They aren't in mainline of
course, but each OS has a slightly different copy for its needs, so my
DKMS packages carry it.

In general, this construct:

> > -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6))
> > -static int inline scsi_device_online(struct scsi_device *sdev)
> > -{
> > -	return sdev->online;
> > -}
> > -#endif

is better tested as:

#ifndef scsi_device_inline
static int inline scsi_device_online(struct scsi_device *sdev)
{
    return sdev->online;
}
#endif

when you can.  It cleanly eliminates the version test, and tests for
exactly what you're looking for - is this function defined.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
