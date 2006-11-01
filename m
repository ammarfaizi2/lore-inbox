Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946237AbWKAAYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946237AbWKAAYT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946238AbWKAAYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:24:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:41230 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946237AbWKAAYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:24:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ln222N9n9bnbe5F3gaded9YPzeoNnofyovoBDHYznvrmgM20WyQxGr7bvPJyk2ULm9jUsEhhtejp60q/vZPowgvFk2FoKaP8UCESVk0l+FH7/8QXDrcs7l9ThxaM6PWAhceSjv/lzFrt3C9yoilS27ySAW/gVqqVSdZDNe3hKEg=
Message-ID: <653402b90610311624m549adc79p3f9eec3bf9be4f12@mail.gmail.com>
Date: Wed, 1 Nov 2006 00:24:17 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH update5] drivers: add LCD support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061031155445.02f1aa6b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061101003748.434a83f4.maxextreme@gmail.com>
	 <20061031155445.02f1aa6b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 1 Nov 2006 00:37:48 +0000
> Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:
>
> > Andrew, here it is the fifth update for the drivers-add-lcd-support.
>
> It does queue_delayed_work(), but forgot to do cancel_delayed_work().  If
> the timer is still pending after module unload, deadly things will happen.
>

Hum, I call cancel_delayed_work() as well as flush_workqueue() at module exit:

static void __exit cfag12864b_exit(void)
{
...
+       cfag12864b_disable();
...
}

And cfag12864b_disable() will call them, as fast as the mutex is
unlocked (in fact, modules must call cfag12864b_disable() when they
finish working with the LCD, as cfag12864bfb, for example, does, but
just for be safe, I called it at module unload in cfag12864b. If it is
already disabled, it won't hurt in any way.)

Is that right?

> There's a lot of "if(" in there.  Usual kernel style is "if (".
>

Excuse me, will fix in a few moments.
