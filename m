Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUHCWmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUHCWmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUHCWmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:42:23 -0400
Received: from hermes.ceid.upatras.gr ([150.140.141.168]:52136 "HELO
	hermes.ceid.upatras.gr") by vger.kernel.org with SMTP
	id S266892AbUHCWmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:42:21 -0400
X-Qmail-Scanner-Mail-From: kernoulas@sisifus.ceid.upatras.gr via hermes
X-Qmail-Scanner: 1.21st (Clear:RC:0(213.16.162.146):SA:0(0.3/5.0):. Processed in 1.183393 secs)
Message-ID: <410FD47A.1010603@sisifus.ceid.upatras.gr>
Date: Tue, 03 Aug 2004 21:07:54 +0300
From: Kernoulas <kernoulas@sisifus.ceid.upatras.gr>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040628)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ramesh Sudini <rameshred@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Copy_to_user and copy_from_user
References: <BAY12-F12PkQTGpaoG100000364@hotmail.com>
In-Reply-To: <BAY12-F12PkQTGpaoG100000364@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No you cannot call it until all data has been copied. 
copy_{to,from}_user fails when a fault happens during the copy process. 
So you simply cannot try again... It will fault again.
Well, not 100% true. An other running thread (same mm with the process 
which copies data) can "fix" the faulty adress space. Bad thread....

Ramesh Sudini wrote:
> Hi,
> 
> If copy_from_user returns non zero value, then I do not see any 
> driver(for example PPP) try to copy the remaining data. It treats it as 
> an error scenario.
> 
> Why is this? Shouldnt it have a while loop and attempt to copy_from_user 
> till all the data is copied??
> 
> I am writing a driver and trying to understand what needs to be done in 
> case it returns a non-zero value? I have huge amount of data to be 
> copied from user space Ex: 3000byte messages.
> 
> Can somebody suggest me what is the best I could do...(Please cc me 
> personally with your response)
> 
> Thanks
> Ramesh
> 
