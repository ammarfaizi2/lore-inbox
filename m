Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265162AbUELSmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbUELSmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbUELSmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:42:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29568 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265162AbUELSmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:42:18 -0400
Message-ID: <40A26FFA.4030701@pobox.com>
Date: Wed, 12 May 2004 14:42:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org,
       Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com>
In-Reply-To: <20040512181903.GG13421@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, May 12, 2004 at 02:07:00AM -0700, Andrew Morton wrote:
> 
>>drivers/usb/host/ehci.h:599: warning: `MSEC_TO_JIFFIES' redefined
>>include/asm/param.h:9: warning: this is the location of the previous definition
>>In file included from drivers/usb/host/ohci-hcd.c:127:
>>drivers/usb/host/ohci.h:400: warning: `MSEC_TO_JIFFIES' redefined
>>include/asm/param.h:9: warning: this is the location of the previous definition
> 
> 
> Woah, that's new.  And wrong.  The code in include/asm-i386/param.h that
> says:
> 	# define JIFFIES_TO_MSEC(x)     (x)
> 	# define MSEC_TO_JIFFIES(x)     (x)
> 
> Is not correct.  Look at kernel/sched.c for verification of this :)


Yes, that is _massively_ broken.

Tangent:
One of the SCTP folks was cleaning up all the random jif-to-msec and 
msec-to-jif macros into include/linux/time.h.  Need to dig that up and 
merge it.

	Jeff



