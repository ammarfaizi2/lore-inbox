Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVKLNsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVKLNsk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 08:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKLNsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 08:48:40 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:20373 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932368AbVKLNsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 08:48:40 -0500
Message-ID: <4375F2C1.8050609@free.fr>
Date: Sat, 12 Nov 2005 14:48:49 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix leakes in request_firmware_nowait
References: <4373BF82.40003@free.fr>	<4373C03F.1070301@free.fr> <20051111181322.7fbb887a.akpm@osdl.org>
In-Reply-To: <20051111181322.7fbb887a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> matthieu castet <castet.matthieu@free.fr> wrote:
> 
> 
> What does the call to fw_work->cont(NULL, ...) do?
> 
> 
It tells to the callback that the firmware request fails [1].

Matthieu



[1]
/**
  * request_firmware_nowait:
  *
  * Description:
  *      Asynchronous variant of request_firmware() for contexts where
  *      it is not possible to sleep.
  *
  *      @hotplug invokes hotplug event to copy the firmware image if 
this flag
  *      is non-zero else the firmware copy must be done manually.
  *
  *      @cont will be called asynchronously when the firmware request 
is over.
  *
  *      @context will be passed over to @cont.
  *
  *      @fw may be %NULL if firmware request fails.
  *
  **/
int
request_firmware_nowait(
         struct module *module, int hotplug,
         const char *name, struct device *device, void *context,
         void (*cont)(const struct firmware *fw, void *context))
