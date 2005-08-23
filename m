Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVHWTlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVHWTlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVHWTlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:41:12 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:6735 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932336AbVHWTlL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:41:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XNm58z37PNa0bnO0CJuLOre8SWSANacz+Q8y47x90nF0TCKEWEmFRDQbQxQhmXjlTZV5QHZuJYQaCw7tiiyfiGbflMSBL21wabdsok1z4egPS7Z6tmJI/GsnCGV+EYf0qNagrdaKfaM08j0Ay0jvFzo4aAxDlA6LRdR/6bnSijk=
Message-ID: <4789af9e050823124140eb924f@mail.gmail.com>
Date: Tue, 23 Aug 2005 13:41:09 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
To: Linux-ide <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #2
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <355e5e5e05080103021a8239df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <355e5e5e05080103021a8239df@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/05, Lukasz Kosewski <lkosewsk@gmail.com> wrote:
> Patch 03:  Have sata_promise use the perfect, flawless API from the
> previous patch

Hmmm... Flawless :)

Then I must have found an undocumented feature!  I've applied this set
of patches to a 2.6.11 kernel (with few problems) and ran into a bunch
of "scheduling while atomic" errors when hotplugging a drive, culprit
being probably scsi_sysfs.c where scsi_remove_device locks a mutex, or
perhaps when it then calls class_device_unregister, which does a
'down_write'.

Perhaps we need some sort of workqueue for hotplug requests to get
them out of the atomic interrupt handler context where they originate?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
