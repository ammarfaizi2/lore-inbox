Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965331AbVKHG5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331AbVKHG5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965333AbVKHG5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:57:05 -0500
Received: from [85.8.13.51] ([85.8.13.51]:7832 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965331AbVKHG5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:57:04 -0500
Message-ID: <43704C3D.30602@drzeus.cx>
Date: Tue, 08 Nov 2005 07:57:01 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] wbsd pnp suspend
References: <20051108064100.18059.79712.stgit@poseidon.drzeus.cx> <20051107225019.7cd01a77.akpm@osdl.org>
In-Reply-To: <20051107225019.7cd01a77.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Pierre Ossman <drzeus@drzeus.cx> wrote:
>> Allow the wbsd driver to use the new suspend/resume functions added to
>> the PnP layer.
>>
> 
> Doesn't Russell handle mmc stuff?
> 

Yup. But this needs the PnP suspend stuff in your patch set.

>> -static int wbsd_suspend(struct device *dev, pm_message_t state)
>> +static int wbsd_suspend(struct wbsd_host *host, pm_message_t state)
>> +{
>> +	BUG_ON(host == NULL);
>> +
>> +	return mmc_suspend_host(host->mmc, state);
>> +}
> 
> There's not much point in this BUG_ON.  If host==0 then we'll get a
> perfectly good oops in the next statement - it's just as informative.
> 

I suppose. I just have a tendency to scatter assertions all over the 
place. :)

>> +	if (host->config != 0)
>> +	{
>> +		if (!wbsd_chip_validate(host))
>> +		{
> 
> Like:
> 
> 	if (host->config != 0) {
> 		if (!wbsd_chip_validate(host)) {
> 
> please.
> 

We had this discussion the last patch for this driver. It's horribly 
wrong when it comes to coding style so keeping patches in the same style 
as the rest of the driver is the lesser evil (IMHO).

Rgds
Pierre

