Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUISS17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUISS17 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 14:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUISS17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 14:27:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15545 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261875AbUISS14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 14:27:56 -0400
Message-ID: <414DCF60.1070104@pobox.com>
Date: Sun, 19 Sep 2004 14:26:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Dillow <dave@thedillows.org>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] reduce stack usage in ixgb_ethtool_ioctl
References: <200409192033.56716.vda@port.imtp.ilyichevsk.odessa.ua> <1095618283.4870.0.camel@dillow.idleaire.com>
In-Reply-To: <1095618283.4870.0.camel@dillow.idleaire.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Dillow wrote:
> On Sun, 2004-09-19 at 13:33, Denis Vlasenko wrote:
> 
>>Stack usage is still high because gcc will
>>allocate too much space for these cases:
>>
>>        case ETHTOOL_GSET:{
>>                        struct ethtool_cmd ecmd = { ETHTOOL_GSET };
>>                        ixgb_ethtool_gset(adapter, &ecmd);
>>                        if (copy_to_user(addr, &ecmd, sizeof(ecmd)))
>>                                return -EFAULT;
>>                        return 0;
>>                }
>>        case ETHTOOL_SSET:{
>>                        struct ethtool_cmd ecmd;
>>                        if (copy_from_user(&ecmd, addr, sizeof(ecmd)))
>>                                return -EFAULT;
>>                        return ixgb_ethtool_sset(adapter, &ecmd);
>>                }
>>
>>There will be space for _two_ ecmd's on stack.
>>
>>Shall it be worked around with ugly union of structs
>>or we'll just wait for better gcc?
> 
> 
> You could convert it to use ethtool_ops.

Check -mm to make sure viro hasn't already converted it to ethtool_ops...

	Jeff


