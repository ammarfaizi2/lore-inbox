Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVA0OEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVA0OEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVA0OEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:04:34 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:33409 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262630AbVA0OEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:04:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nTiExh/Vx8vvWXq2i+0uBb6228eZZEncfz/osxHfyDhZmhU1PajXjXGjLfkEc98405DN6m1H9+ZNyK/6SGOAwpl+5CGf9ZXYa2651FoxlVOjeA0qJVZurKGPYbPBKFe9SOb+kAr8dzHt9qL4O8JI8fKDzMuhd4l5KrnhlFgf33s=
Message-ID: <d120d50005012706045b2e84af@mail.gmail.com>
Date: Thu, 27 Jan 2005 09:04:06 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/16] New set of input patches
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d50005011312166fd03c56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412290217.36282.dtor_core@ameritech.net>
	 <20050113153644.GA18939@ucw.cz>
	 <d120d50005011309526326afef@mail.gmail.com>
	 <20050113192525.GA4680@ucw.cz>
	 <d120d50005011312166fd03c56@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

I have dropped the patches that have already been applied and
re-diffed the remaining patches. I have also merged Adrian's global ->
static cleanup and 2 patches from Prarit Bhargava (one re: releasing
resources acquired by i8042_platform_init if controller initialization
fails and the other is re: making educating guess whether controller
is absent or really times out).

There also was couple of additional changes - serio drivers now use
MODULE_DEVICE_TABLE to export information about the ports they can
possible work with; serio core exports port's type, protocol, id and
"extra" data as sysfs attributes and there is hotplug function to
signal userspace about new port. This all was done so that hotplug can
automatically load appropriate driver (for example psmouse) when a new
port is detected. I have patches for module-init-tools and hotplug
scripts that I will sent to Greg and Rusty as soon as you take the
pathes (if you will).

I think that the very first path ("while true; do xset led 3; xset
-led 3; done" makes keyboard miss release events and makes it
unusable) should go in 2.6.11 so please do:

        bk pull bk://dtor.bkbits.net/for-2.6.11

That repository has only this change. The rest of the patches are in
my usual repository:

        bk pull bk://dtor.bkbits.net/input

I am not sending the patches separately as they had been posted to the
lists couple of times already.

-- 
Dmitry
