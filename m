Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbULQThd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbULQThd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbULQTgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:36:04 -0500
Received: from neopsis.com ([213.239.204.14]:50819 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S262133AbULQTed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:34:33 -0500
Message-ID: <41C335FA.2050009@dbservice.com>
Date: Fri, 17 Dec 2004 20:39:38 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-os@analogic.com, Bill Davidsen <davidsen@tmr.com>,
       James Morris <jmorris@redhat.com>, Patrick McHardy <kaber@trash.net>,
       Bryan Fulton <bryan@coverity.com>, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [Coverity] Untrusted user data in kernel
References: <41C26DD1.7070006@trash.net> <Pine.LNX.4.61.0412171108340.4216@chaos.analogic.com> <41C330F7.4000806@dbservice.com> <200412172030.04831.oliver@neukum.org>
In-Reply-To: <200412172030.04831.oliver@neukum.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
>>But the difference between you example (cp /dev/zero /dev/mem) and 
>>passing unchecked data to the kernel is... you _can_ check the data and 
> 
> 
> This is the difference:
> static int open_port(struct inode * inode, struct file * filp)
> {
> 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
> }
> (from mem.c)
> 

OK, but my point was, whenever you can check the 'contents' of the data 
passed to the kernel, do it. You can't check if the data someone writes 
to /dev/mem is valid or not, but you can check for out-of-range/etc. 
data in ioctl & friends.

tom

