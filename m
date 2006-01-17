Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWAQNRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWAQNRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWAQNRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:17:44 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:49396 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932327AbWAQNRn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:17:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=MXFGeHxjEUvSNNsc6EbGGcuqXUvTiQxQdTeh9VAr2MK1sRcRioe8AkJapXKSraIFxTgBgUuK2xPjRCeQySfC+Wi42lhagyoxmKvGTzzp/sJ2NUkzCTXAYgMTECZsM2bHbotKnm+VKud+jNuCpoopw07LhgioLX0os9/sxBjTxO0=
Date: Tue, 17 Jan 2006 14:17:25 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with current linus' git tree
Message-Id: <20060117141725.d80a1221.diegocg@gmail.com>
In-Reply-To: <43CC7094.9040404@yahoo.com.au>
References: <20060116191556.bd3f551c.diegocg@gmail.com>
	<43CC7094.9040404@yahoo.com.au>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 17 Jan 2006 15:20:36 +1100,
Nick Piggin <nickpiggin@yahoo.com.au> escribió:

>  From your oops it looks as though the radix_tree_lookup in find_get_page
> has returned 0x40. It could be a flipped bit - is your memory OK?

It's ECC memory, I'd doubt it.


> Can you apply the attached patch and try to reproduce the oops?

You're saying that I'll have to spend all the afternoon watching
DVDs? Well, if the linux kernel needs it!


> What happens if you run several infinite loops to increase the load?
> Does everything still stay on CPU0?

Yes, I run several "cat /dev/zero > /dev/null &" and they all kept in
CPU #0. 

I did a bitsection search and I couldn't found the culprit, apparently
it is caused by a config option; now it works fine after switching off
CONFIG_HOTPLUG_CPU and some ACPI options. Also, when it didn't work
the CPU that would get all the processes could be CPU #0 or #1 - it
changed randomly depending on the boot.
