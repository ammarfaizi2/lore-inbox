Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUCZTDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbUCZTDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:03:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41946 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262205AbUCZTDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 14:03:15 -0500
Message-ID: <40647E65.7020903@pobox.com>
Date: Fri, 26 Mar 2004 14:03:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sridhar Samudrala <sri@us.ibm.com>
CC: Edgar Toernig <froese@gmx.de>, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Consolidate multiple implementations of jiffies-msecs
 conversions.
References: <Pine.LNX.4.58.0403251142110.3037@localhost.localdomain> <20040326014403.39388cb8.froese@gmx.de> <Pine.LNX.4.58.0403261007370.6718@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0403261007370.6718@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sridhar Samudrala wrote:
> On Fri, 26 Mar 2004, Edgar Toernig wrote:
> 
> 
>>Sridhar Samudrala wrote:
>>
>>>The following patch to 2.6.5-rc2 consolidates 6 different implementations
>>>of msecs to jiffies and 3 different implementation of jiffies to msecs.
>>>All of them now use the generic msecs_to_jiffies() and jiffies_to_msecs()
>>>that are added to include/linux/time.h
>>>[...]
>>>-#define MSECS(ms)  (((ms)*HZ/1000)+1)
>>>-return (((ms)*HZ+999)/1000);
>>>+return (msecs / 1000) * HZ + (msecs % 1000) * HZ / 1000;
>>
>>Did you check that all users of the new version will work correctly
>>with your rounding?  Explicit round-up of delays is often required,
>>especially when talking to hardware...
> 
> 
> I don't see any issues with the 2.6 default HZ value of 1000 as they become
> no-ops and there is no need for any rounding.
> I guess you are referring to cases when HZ < 1000(ex: 100) and msecs is
> less than 10. In those cases, the new version returns 0, whereas some of the
> older versions return 1.

We'll definitely want to return 1 rather than zero, for the uses in my 
drivers, at least...

	Jeff




