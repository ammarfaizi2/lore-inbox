Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVASOF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVASOF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVASOF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:05:26 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:9677 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261725AbVASOFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:05:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lz9KbMpySluQYY+afDtFaPzjIzT4bV4R3/na3fGU8jUiVgTZO7tE0w5GZbi2Igqh1AMk6XYWhiRphJch3WeW5+lLdjZ05g3Q37GOXCyz8MRxj3xQjv99hOzF92bL7VDvqiBnVUNqLJZUWasqRKaEv4qZmNRw2Szd/XthgYVywZQ=
Message-ID: <d120d500050119060530b57cd7@mail.gmail.com>
Date: Wed, 19 Jan 2005 09:05:18 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] Remove input_call_hotplug
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <41EE2F82.3080401@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ED2457.1030109@suse.de>
	 <d120d50005011807566ee35b2b@mail.gmail.com> <41EE2F82.3080401@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hannes, 

On Wed, 19 Jan 2005 10:59:30 +0100, Hannes Reinecke <hare@suse.de> wrote:
> Dmitry Torokhov wrote:
> > But the real question is whether we really need class devices have
> > unique names or we could do with inputX thus leaving individual
> > drivers intact and only modifying the input core. As far as I
> > understand userspace should be concerned only with device
> > capabilities, not particular name, besides, it gets PRODUCT string
> > which has all needed data encoded.
> >
> Indeed. What about using 'phys' (with all '/' replaced by '-') as the
> class_id? This way we'll retain compability with /proc/bus/input/devices
> and do not have to touch every single driver.
> 

I want to kill phys at some point - we have topology information
already present in sysfs in much better form. Can we have a new
hotplug variable HWDEV= which is kobject_path(input_dev->dev). If
input_dev is not set then we can just dump phys in it. And the class
id will still be inputX. Will this work?
 
Btw, I really doubt that topology information is important here as the
only thing that one needs to do when new "input_device" appears is to
load one or more input handler modules based on device's capability
bits. The decision whether a device is "good enough" to create a
device node should be done by hotplug handler for the other "input"
class.

-- 
Dmitry
