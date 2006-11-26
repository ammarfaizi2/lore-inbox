Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935356AbWKZUiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935356AbWKZUiV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 15:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935552AbWKZUiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 15:38:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:39219 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S935356AbWKZUiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 15:38:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=uVoHpw74myzdR7ThTm9I2HfAFWze8a030Q6zrh6/IKBt3S+c8QP9LPwDSlpUAGlXIMPsC++km3GvMSivQe0ZOskNfP02Lq2XJ4wxBkNWW2C2M7vPlkUEWJzlujz6ZIF7+VeTt6+5kItkuOnfB2lb8IlQlXS1u4t1oOpugAidQ84=
Date: Sun, 26 Nov 2006 23:38:16 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Johnson <dj@david-web.co.uk>
Subject: Re: Changing sysctl values within the kernel?
Message-ID: <20061126203816.GA5032@martell.zuzino.mipt.ru>
References: <200611251911.48961.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611251911.48961.dj@david-web.co.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 07:11:48PM +0000, David Johnson wrote:
> I'm working on a kernel module and want to change sysctl values (specifically
> stop-a and printk) in response to a hardware event.
>
> Is there an accepted way of setting sysctl values within the kernel (I can't
> seem to find any other module doing this),

Yes. Next in-kernel module changing sysctls will do it via

	stop_a_enabled = 1;
	console_loglevel = 8;

(be sure, variables in question are EXPORT_SYMBOL'ed)

> or is it a completely silly idea?

Without more details it's hard to tell.

> Would it perhaps be better to instead create a sysfs node and let a userspace
> daemon worry about setting the sysctl values?

Now _this_ is silly. sysctls already live in /proc/sys/, so you can open(2)
/proc/sys/kernel/printk and write(2) to it.

