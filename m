Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269216AbUISLw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269216AbUISLw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 07:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUISLw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 07:52:57 -0400
Received: from main.gmane.org ([80.91.229.2]:7134 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269216AbUISLwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 07:52:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: udev is too slow creating devices
Date: Sun, 19 Sep 2004 17:53:05 +0600
Message-ID: <cijrui$g9s$1@sea.gmane.org>
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston> <414D42F6.5010609@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 80.78.110.194
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <414D42F6.5010609@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar 'Philips' Filipau wrote:
> Benjamin Herrenschmidt wrote:
> 
>>
>> Nope, Greg is right. Drivers themselves won't necessarily provide
>> you with the device interface in a synchronous way after they are
>> loaded, and some will certainly never. It is all an asynchronous process
>> and there is simply no way to ask for any kind of enforced synchronicity
>> here without major bloatage.
>>
> 
>   Okay, okay. Let's spread delays and polling all over numerous init 
> scripts.

I read it as "Let's bloat initscripts instead of the kernel". We 
probably have to bloat something, but we don't want to bloat our 
favourite kernel.

Maybe we should create a bash file with functions that implement it "the 
right way" and distribute this file with udev as an example?

>   You might be ten thousands time right. It is asynchronous process.
> 
>   But please listen to me: you are not going to handle that in _every_ 
> system application which deals with modules.

We should probably avoid code duplication and put this functionality 
into a library (maybe even glibc?)

What we currently see is that distros either ignore the race or (like 
LFS) say something like:

"Because of all those compilcations with Hotplug, Udev and modules, we 
strongly recommend you to start with a completely non-modular kernel 
configuration, especially if this is the first time you use Udev."

-- 
Alexander E. Patrakov

