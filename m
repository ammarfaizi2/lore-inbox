Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWDWXlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWDWXlM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 19:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWDWXlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 19:41:12 -0400
Received: from pproxy.gmail.com ([64.233.166.182]:3543 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751180AbWDWXlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 19:41:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gYkhFzCpa1TbZAqKnsPdOcVcPz8IU1W9VH+/fiWUX4i0blNiadEy/Q64fRR01xc8MuA/lETi7p5JxTPcQUM6UwLLE4n43EPENmv+XeSoE6w8WkFc6FTXuayk5zPHF37wMSSFFWzJVL9+HhITfzWHjCVFQuRbwCdXqG/vXTJYjpQ=
Message-ID: <444C108B.9090801@gmail.com>
Date: Mon, 24 Apr 2006 07:40:59 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] VBE DDC bios call stalls boot
References: <df35dfeb0604231208x416b7ab0ya612d918bb239140@mail.gmail.com> <200604232214.32662.ioe-lkml@rameria.de>
In-Reply-To: <200604232214.32662.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Sunday, 23. April 2006 21:08, Yum Rayan wrote:
>> I don't think boot should stall for any reason. Moreover given that
>> user space programs are doing these VBE/DDC calls, I don't see any
>> compelling reason why this code need to exist is such early boot
>> stage. If it absolutely needs to be called in the kernel, at least if
>> invoked sometime later, we could time out this call as a workaround.
> 
> Don't configure CONFIG_FB_FIRMWARE_EDID, if it doesn't work
> on your hardware. 

This option is new and not yet available in 2.6.15, so you may have
to use your patch temporarily. If you can, set CONFIG_VIDEO_SELECT = n
in Device Drivers -> Graphics support -> Console Drivers ->
Video mode selection support. However, this is automatically selected by FB, 
PCI, and X86_32, so it may not be changeable.

The "vga=" option will not be available if VIDEO_SELECT is not set.

Or just apply this changeset:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=59153f7d7effdb5b3c81eb6d03914a866157b319

to make CONFIG_FB_FIRMWARE_EDID available.

Tony
