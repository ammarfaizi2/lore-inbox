Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVJFRrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVJFRrB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJFRrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:47:01 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:33840 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751263AbVJFRrB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:47:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FD904YplYZmT7gDw7P6yOuUq3ByKiaa3iwnve7NxTY6toIJ+ZkiaiIRfwYJE/vbtTQKeTlqA3sO8IpacFySePSEMe2gwsbBRCiQB5BgL1M3oY8i3yu/7281oW4IOjMgicKu1zpuxbHtipUTj3g1q/etT7GAApw0PTmM9B/iyVmY=
Message-ID: <d120d5000510061046y7d36de9cseccbbbd18529678@mail.gmail.com>
Date: Thu, 6 Oct 2005 12:46:59 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: [patch 08/28] Input: prepare to sysfs integration
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
In-Reply-To: <20051005225504.GA3566@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050915070131.813650000.dtor_core@ameritech.net>
	 <20050915070302.813567000.dtor_core@ameritech.net>
	 <20051005220316.GA2932@suse.de>
	 <d120d5000510051517k28bbb1f9v3c7ec7448608926@mail.gmail.com>
	 <20051005225504.GA3566@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/05, Greg KH <gregkh@suse.de> wrote:
> On Wed, Oct 05, 2005 at 05:17:00PM -0500, Dmitry Torokhov wrote:
>
> > The reason is that I want to change input_allocate_device to take
> > bitmap of supported events. This way I could allocate ABS tables
> > dynamically at the same time I allocate input_dev itself and it will
> > simplify error handling logic in drivers and it will save I think 1260
> > bytes per input_dev structure which is nice. And I don't want to go
> > through all subsystems yet again soI want to fold into my input
> > dynalloc patch...
>
> That sounds good.
>

Well, I tried implementing the proposal above and interface came out
pretty awkward to use. My next option is to move abs table into
"->private" structure, much like keytable was moved, or (for HID-like
devices) allocate it when actually needed and adjust individual
drivers. So I guess the patches that you have right now are good after
all.

--
Dmitry
