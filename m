Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUK0WR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUK0WR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 17:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbUK0WRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 17:17:25 -0500
Received: from science.horizon.com ([192.35.100.1]:58697 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261351AbUK0WRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 17:17:21 -0500
Date: 27 Nov 2004 22:17:20 -0000
Message-ID: <20041127221720.16853.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document kfree and vfree NULL usage
Cc: kernel@linuxace.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> -	if (mfile) {
>> -		kfree(mfile);
>> -	} else {
>> +	kfree(mfile);
>> +	if (!mfile) {
>>  		snd_printk(KERN_ERR "ALSA card file remove problem (%p)\n", file);
>>  		return -ENOENT;
>>  	}

> The above change seems to always trigger the ENOENT return, no?

No.  kfree(mfile) doesn't magically change the numerical value of mfile.
Dereferencing it now would be a bad idea, but you can still look at it.

(The ANSI C standard envisions architectures on which just *looking* at
a dangling pointer is illegal, but Linux makes slightly tighter
restrictions.)
