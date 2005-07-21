Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVGUWv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVGUWv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVGUWvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:51:22 -0400
Received: from [216.208.38.107] ([216.208.38.107]:5000 "EHLO OTTLS.pngxnet.com")
	by vger.kernel.org with ESMTP id S261932AbVGUWvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:51:18 -0400
Subject: Re: [PATCH] serverworks should not take ahold of megaraid'd
	controllers
From: Arjan van de Ven <arjan@infradead.org>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       AJ Johnson <blujuice@us.ibm.com>
In-Reply-To: <42E023B2.5030900@us.ibm.com>
References: <42E023B2.5030900@us.ibm.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 18:51:00 -0400
Message-Id: <1121986260.3914.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-21 at 15:37 -0700, Darrick J. Wong wrote:
> Hi all,
> 
> I've noticed what might be a small bug with the serverworks driver in
> 2.6.12.3.  The IBM HS20 blade has a ServerWorks CSB6 IDE controller with
> an optional LSI MegaIDE RAID BIOS (BIOS assisted software raid, iow).
> When this megaide BIOS is enabled on the HS20, the PCI
> subvendor/subdevice IDs on the CSB6 are changed from the default
> (ServerWorks) to IBM.  However, the serverworks driver doesn't notice
> this and will attach to the controller anyway, thus allowing raw access
> to the disks in the RAID.  An unsuspecting user can then read and write
> whatever they want to the drive, which could very well degrade or
> destroy the array, which is clearly not desirable behavior.

actually this is the RIGHT behavior.
This way dmraid can address the raid format and make the thing work.
Your patch will break it. That is a very bad idea.

So this is a NAK on your patch.


