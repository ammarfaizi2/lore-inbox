Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWEPPSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWEPPSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWEPPSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:18:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932075AbWEPPSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:18:38 -0400
Message-ID: <4469ED32.9070002@osdl.org>
Date: Tue, 16 May 2006 08:18:10 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
References: <20060515005637.00b54560.akpm@osdl.org>	<6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>	<20060515115302.5abe7e7e.akpm@osdl.org>	<6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com>	<20060515122613.32661c02.akpm@osdl.org>	<6bffcb0e0605151317u51bbf67ey124b808fad920d36@mail.gmail.com>	<20060516103930.0c0d5d33.khali@linux-fr.org>	<20060516145517.2c2d4fe4.khali@linux-fr.org> <20060516164846.4d42ed11.khali@linux-fr.org>
In-Reply-To: <20060516164846.4d42ed11.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Michal Piotrowski reported:
>   
>>> When I try to "modprobe -r i2c_i801" modprobe hangs
>>>       
>
> Quoting myself:
>   
>> I can reproduce it, with both i2c-i801 and i2c-parport, so it's not
>> related to a specific driver. I'm currently performing a bisection on
>> 2.6.17-rc4-mm1 to try and isolate the culprit. It seems to point to
>> gregkh-driver-*. i2c patches are innocent for sure, including Kumar's
>> ones.
>>     
>
> And the winner is...
> gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
>
> Stephen, Greg?
>
>   
Look at the error return from class_device_register. I bet
it was working before because the class_device_register wasn't
checking something, now it is and that exposes a bug that has
existed in i2c since sysfs support was added.

I can make up a more verbose version if that helps
