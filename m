Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030904AbWI0Vwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030904AbWI0Vwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030908AbWI0Vwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:52:40 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:22471 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030904AbWI0Vwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:52:40 -0400
Message-ID: <451AF29D.2030102@garzik.org>
Date: Wed, 27 Sep 2006 17:52:29 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
CC: pmac@au1.ibm.com, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1] ehea firmware interface based on Anton Blanchard's
 new hvcall interface
References: <200609271847.34258.ossthema@de.ibm.com>
In-Reply-To: <200609271847.34258.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Bernd Themann wrote:
> Hi Jeff, 
> 
> the last patch did not work, so here is the new patch. The patch is build against
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev.2.6.git HEAD today.
> Could you give it a try?

Per the standard patch format in Documentation/SubmittingPatches, these 
sort of comments should go beneath the "---" separator.  Otherwise, if 
they are not hand-edited out, they will go into the final changeset 
description.


> This eHEA patch reflects changes according to Anton's new hvcall interface
> which has been commited in Paul's git tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

When is this going upstream?  I don't want things to get too out-of-sync.


> In addition to the above changes the patch includes a bug fix (port state
> notification) and minor changes (default queue length, coding style updates).

These changes should be in a separate patch.  Makes 'git bisect' work 
better, makes the changes more reviewable, and in general follows the 
"separate logical changes" rule.


> diff -Nurp netdev-2.6/drivers/net/ehea/ehea_ethtool.c netdev-2.6_patched/drivers/net/ehea/ehea_ethtool.c
> --- netdev-2.6/drivers/net/ehea/ehea_ethtool.c	2006-09-26 10:27:38.000000000 +0200
> +++ netdev-2.6_patched/drivers/net/ehea/ehea_ethtool.c	2006-09-26 19:28:22.000000000 +0200
> @@ -270,7 +270,7 @@ static void ehea_get_ethtool_stats(struc
>  	kfree(cb6);
>  }
>  
> -const struct ethtool_ops ehea_ethtool_ops = {
> +struct ethtool_ops ehea_ethtool_ops = {
>  	.get_settings = ehea_get_settings,
>  	.get_drvinfo = ehea_get_drvinfo,
>  	.get_msglevel = ehea_get_msglevel,


This is an obvious regression.

	Jeff


