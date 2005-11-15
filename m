Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVKOD6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVKOD6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVKOD6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:58:52 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:44692 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932355AbVKOD6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:58:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fJcuFZHN4plr4jzKVxeWn+ChcubLbJHLU3byTP5ssmn2js1jo2cX6JDW7oGtQ9akJq4RcUoL3u3Lx4DAJ5kBYPzA0zPaOCyXmnnLrPk1T3scHttpIlyGMcA8zJvvQkR8TiZcsKwvfXLXUCrTfXybCcPZKtueuwws2gxd1/qjsfY=
Message-ID: <43795C71.6070108@gmail.com>
Date: Tue, 15 Nov 2005 11:56:33 +0800
From: Tony <tony.uestc@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MOD_INC_USE_COUNT
References: <437347B5.6080201@gmail.com> <Pine.LNX.4.61.0511100859400.18912@chaos.analogic.com> <43735766.3070205@gmail.com> <20051113102930.GA16973@linux-mips.org>
In-Reply-To: <20051113102930.GA16973@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> On Thu, Nov 10, 2005 at 10:21:26PM +0800, Tony wrote:
> 
> 
>>But when the module is used by a net_device(interface is up), rmmod also 
>>works. Strange, isn't it?
> 
> 
> Not strange at all.  The typical network driver is implemented using
> pci_register_driver which will set the owner filed of the driver's struct
> driver which then is being used for internal reference counting.  Other
> busses or line disciplines (SLIP, PPP, AX.25 ...) need to do the equivalent
> or the kernel will believe reference counting isn't necessary and it's
> ok to unload the module at any time.
> 
> In which driver did you hit this problem?
> 
>   Ralf
> 
I have a radio connected to host using ethernet. I'm writing a radio 
driver that masquerade radio as a NIC. when the module is loaded, I just 
register_netdev a net_device struct, while unregister_netdev at module 
cleanup.

Tony
