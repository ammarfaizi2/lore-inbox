Return-Path: <linux-kernel-owner+w=401wt.eu-S1753932AbWLRMhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbWLRMhm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 07:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbWLRMhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 07:37:42 -0500
Received: from smtp.nokia.com ([131.228.20.172]:48467 "EHLO
	mgw-ext13.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbWLRMhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 07:37:41 -0500
Message-ID: <45868C6F.5000804@indt.org.br>
Date: Mon, 18 Dec 2006 08:41:19 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/4] Add MMC Password Protection (lock/unlock) support
 V8: mmc_sysfs.diff
References: <45748173.2050008@indt.org.br> <20061215193717.GA10367@flint.arm.linux.org.uk>
In-Reply-To: <20061215193717.GA10367@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2006 12:36:28.0210 (UTC) FILETIME=[2362B920:01C722A1]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061218143649-6ABDFBB0-598F6177/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext Russell King wrote:
> On Mon, Dec 04, 2006 at 04:13:39PM -0400, Anderson Briglia wrote:
>> Implement MMC password force erase, remove password, change password,
>> unlock card and assign password operations. It uses the sysfs mechanism
>> to send commands to the MMC subsystem. 
> 
> Sorry, this is still unsuitable for mainline.

Ok. I will fix the code and send another version of this patch on the V9 series e-mail thread.

> 
>> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
>> Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
>> Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
> 
> Please use the standard format, do not obfuscate these.  The kernel
> community utterly abhors this.

Ok.
> 
>> +/*
>> + * implement MMC password functions: force erase, remove password, change
>> + * password, unlock card and assign password.
>> + */
>> +static ssize_t
>> +mmc_lockable_store(struct device *dev, struct device_attribute *att,
>> +	const char *data, size_t len)
>> +{
>> +	struct mmc_card *card = dev_to_mmc_card(dev);
>> +	int err = 0;
> 
> Where is the check that the host can do byte-wise data transfers?

It's checked on the macro "mmc_card_lockable".

> 
>> +
>> +	err = mmc_card_claim_host(card);
>> +	if (err != MMC_ERR_NONE)
>> +		return -EINVAL;
>> +
>> +	if (!mmc_card_lockable(card))
>> +		return -EINVAL;
> 
> So writing to this file with a card which is not lockable results in
> deadlocking the host.  Suggest you do as other subsystems do and have
> one exit path, and use gotos, setting the appropriate return code in a
> variable.  If everything goes via that it forces you to think about
> where you want to jump to in each case.
> 

Thanks, as said before, I'll update the code and send it again.

Best Regards,

Anderson Briglia

