Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUISSYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUISSYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 14:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUISSYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 14:24:54 -0400
Received: from NS1.idleaire.net ([65.220.16.2]:54418 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S261724AbUISSYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 14:24:52 -0400
Subject: Re: [PATCH] reduce stack usage in ixgb_ethtool_ioctl
From: Dave Dillow <dave@thedillows.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <200409192033.56716.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200409192033.56716.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1095618283.4870.0.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 19 Sep 2004 14:24:43 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2004 18:24:47.0202 (UTC) FILETIME=[F16CD420:01C49E75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-19 at 13:33, Denis Vlasenko wrote:
> Stack usage is still high because gcc will
> allocate too much space for these cases:
> 
>         case ETHTOOL_GSET:{
>                         struct ethtool_cmd ecmd = { ETHTOOL_GSET };
>                         ixgb_ethtool_gset(adapter, &ecmd);
>                         if (copy_to_user(addr, &ecmd, sizeof(ecmd)))
>                                 return -EFAULT;
>                         return 0;
>                 }
>         case ETHTOOL_SSET:{
>                         struct ethtool_cmd ecmd;
>                         if (copy_from_user(&ecmd, addr, sizeof(ecmd)))
>                                 return -EFAULT;
>                         return ixgb_ethtool_sset(adapter, &ecmd);
>                 }
> 
> There will be space for _two_ ecmd's on stack.
> 
> Shall it be worked around with ugly union of structs
> or we'll just wait for better gcc?

You could convert it to use ethtool_ops.
-- 
Dave Dillow <dave@thedillows.org>

