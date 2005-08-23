Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVHWWn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVHWWn6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 18:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVHWWn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 18:43:58 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:7082 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932471AbVHWWn5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 18:43:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VuT9VZPgbuFzbfwhXST9FH8dZxCiKKBk5hDc3/AOPT6cJXs6J+0G/2QYKsEhACq59L2IXd9IvBM6y2SkTscz4z+tJNRrZ4G+FJYG4U2l0KsQfrM9JKTE58QKhW/gDtJjFgatA94f00Fz3GAxMzeKIsamyTgld9kksH6zPAg3MEI=
Message-ID: <4789af9e050823154364c8e9eb@mail.gmail.com>
Date: Tue, 23 Aug 2005 16:43:51 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
To: Linux-ide <linux-ide@vger.kernel.org>,
       Lukasz Kosewski <lkosewsk@gmail.com>
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #2
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4789af9e050823124140eb924f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <355e5e5e05080103021a8239df@mail.gmail.com>
	 <4789af9e050823124140eb924f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/05, Jim Ramsay <jim.ramsay@gmail.com> wrote:
> Then I must have found an undocumented feature!  I've applied this set
> of patches to a 2.6.11 kernel (with few problems) and ran into a bunch
> of "scheduling while atomic" errors when hotplugging a drive, culprit
> being probably scsi_sysfs.c where scsi_remove_device locks a mutex, or
> perhaps when it then calls class_device_unregister, which does a
> 'down_write'.

After further debugging, it appears that the problem is the debounce
timer in libata-core.c.

Timers appear to operate in an atomic context, so timers should not be
allowed to call scsi_remove_device, which eventually schedules.

Any suggestions on the best way to fix this?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
