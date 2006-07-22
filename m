Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWGVCJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWGVCJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 22:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWGVCJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 22:09:08 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:45092 "EHLO
	asav07.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751108AbWGVCJH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 22:09:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAGYkwUSBTw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Magnus =?utf-8?q?Vigerl=C3=B6f?= <wigge@bigfoot.com>
Subject: Re: [RFC] input: Wacom tablet driver for simple X hotplugging
Date: Fri, 21 Jul 2006 22:09:04 -0400
User-Agent: KMail/1.9.3
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20060721211341.5366.93270.sendpatchset@pipe>
In-Reply-To: <20060721211341.5366.93270.sendpatchset@pipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607212209.05254.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Magnus,

On Friday 21 July 2006 17:13, Magnus Vigerlöf wrote:
> I'd appreciate whether you think this is a viable idea to make it as a
> generic driver instead or should I continue with the Wacom-specific
> one. I know the 'right' thing would be to make X truly hot-plug aware,
> but this driver is something that would be possible to use in current
> systems without any problems.
> 

Yes, I think fixing X would ultimately be time better spent. 

> If it is a viable idea; Which other devices/types of device do you
> think could be of interest to handle in a similar fashion? Tablets of
> different makes/models are obvious, but are there any others that
> would benefit from a similar driver?
> 

I do not think that creating device-specific "drivers" is a good idea
even short term, especially in kernel. If you want a "persistent"
device just create a userspace daemon and listen for hotplug events.
When you see the input device you interested in grab it and pipe all
data into somewhere. Next time you see hotplug event for the same
device release the old instance and grab the new one. In cases when
final recepient of events uses ioctls to query input devices capabilities
you can create uinput feed back into kernel. This way your program will
work for all types of input devices and no kernel changes are needed.

-- 
Dmitry
