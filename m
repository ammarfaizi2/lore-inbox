Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262879AbVD2Skx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbVD2Skx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVD2Skw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:40:52 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:58281 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262879AbVD2SkT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:40:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GAXfSq8pvRLsGX47P/WoBOk1QbtGhjSUtYNg1hiRX98li6Li4XGysSB3f7KqCfZXoJfr/HhuXEQsuz6ASe/yjd2RTfOr5RZ0USdABJwBfIswELjTxwfpGICpUdxlhygBk2CrzzXMsDJqaroZa1lGs8190SMSQvZ2PNjnQ8nOUQI=
Message-ID: <29495f1d050429114048da1847@mail.gmail.com>
Date: Fri, 29 Apr 2005 11:40:19 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
Subject: Re: msleep_interruptible() in ethtool ioctl and keyboard input
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E05195E08@orsmsx408>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <468F3FDA28AA87429AD807992E22D07E05195E08@orsmsx408>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/05, Venkatesan, Ganesh <ganesh.venkatesan@intel.com> wrote:

<snip>
 
> Please send me comments/ideas for further tests/questions for more data.
> 
> Following is the logic that implements the blinking:

<snip>

> static int
> e1000_phys_id(struct net_device *netdev, uint32_t data)
> {
>         struct e1000_adapter *adapter = netdev->priv;
> 
>         if(!data || data > (uint32_t)(MAX_SCHEDULE_TIMEOUT / HZ))
>                 data = (uint32_t)(MAX_SCHEDULE_TIMEOUT / HZ);
> 
>         if(!adapter->blink_timer.function) {
>                 init_timer(&adapter->blink_timer);
>                 adapter->blink_timer.function =
> e1000_led_blink_callback;
>                 adapter->blink_timer.data = (unsigned long) adapter;
>         }
> 
>         e1000_setup_led(&adapter->hw);
>         mod_timer(&adapter->blink_timer, jiffies);

You really want this timer to go off immediately?

Regardless....

>         msleep_interruptible(data * 1000);

Does the same issue occur if you revert this change and make it

set_current_state(TASK_INTERRUPTIBLE);
schedule_timeout(data * HZ);

?

Thanks,
Nish
