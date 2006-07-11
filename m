Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWGKKhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWGKKhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWGKKhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:37:10 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:55995 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750976AbWGKKhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:37:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iUu3+fEnEnoBgZwb/XkvEz6XD78zCLGNHuiN29iHTNAfmwt86MIEZO+Uge2vMxqAdUbhA9rSByJPCydTzuBJvYMCN7o7QH+fq52AUMwLdxW7TFEBrP7Nn9UWos9VL1e+Q2l3rWJB3YmhngsWHWZ/9n2Gy0fr/G5v8WQLuTLVxVU=
Message-ID: <44B37F44.5080501@gmail.com>
Date: Tue, 11 Jul 2006 18:36:52 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rdunlap@xenotime.net, mreuther@umich.edu, linux-kernel@vger.kernel.org,
       zap@homelink.ru
Subject: Re: [PATCH] backlight: lcd: Remove dependency from the framebuffer
 layer
References: <200607100833.00461.mreuther@umich.edu>	<20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>	<44B27931.30609@gmail.com>	<200607102327.38426.mreuther@umich.edu>	<20060710215253.1fcaab57.rdunlap@xenotime.net>	<44B34D68.3080602@gmail.com> <20060711032817.94c78ae0.akpm@osdl.org>
In-Reply-To: <20060711032817.94c78ae0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 11 Jul 2006 15:04:08 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> +#if defined(CONFIG_FB) || (defined(CONFIG_FB_MODULE) && \
>> +			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
> 
> Peeking at CONFIG_FB_MODULE like this is considered sinful.
> 
> <tries to remember why>
> 
> Because someone might build a CONFIG_FB=n, CONFIG_FB_MODULE=n kernel, then
> later build the fbdev module for that kernel only to find that the
> backlight driver doesn't know that the fbdev module is available.
> 
> Or something like that.  It's pretty contrived, and I really doubt that
> anyone's going to try to cobble together a kernel like that.
> 
> Or maybe there's a better reason...

That's the simplest method I can think of to prevent impossible
combinations such as CONFIG_FB=m, CONFIG_BACKLIGHT_CLASS_DEVICE=y
without having to use 'depend' or 'select' in Kconfig, or God forbid,
inter_module_get().

I should have added a comment that I also don't like the hackishness
of this method.

Thinking about this a little more carefully now, how about we just statically
link the fb notification?
 
I'll see if I can send an update for that.

Tony

 

