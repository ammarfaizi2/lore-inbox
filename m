Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWHaDFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWHaDFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 23:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWHaDFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 23:05:43 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:7 "EHLO
	asav08.insightbb.com") by vger.kernel.org with ESMTP
	id S932068AbWHaDFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 23:05:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HALvu9USBT4lYLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Ivo van Doorn <ivdoorn@gmail.com>
Subject: Re: [PATCH] RFKILL - Add support for input key to control wireless radio
Date: Wed, 30 Aug 2006 23:05:40 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>
References: <200608271534.58503.IvDoorn@gmail.com> <d120d5000608280847n221b6d89y93c8cba747d84890@mail.gmail.com> <200608282215.14480.IvDoorn@gmail.com>
In-Reply-To: <200608282215.14480.IvDoorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608302305.41075.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 16:15, Ivo van Doorn wrote:
> > 
> > I am not sure if this is a correct approach, kernel should not assume
> > that the reason why input device was opened is to control the state of
> > the transmitter. For example one could be happy with hardware toggling
> > the state but still want to have for example a GKrellm showing state
> > of the transmitter.
> 
> Valid point, but when the radio is disabled a wireless interface should
> report a txpower of 0. I don't know if this is also the case for bluetooth or irda..
> 

Exactly...

> > Also please explain how userspace would control the state of
> > transmitter once KEY_RFKILL is received - there seems to be only
> > kernel->userspace link, but not userspace->kernel.
> 
> Plain ifconfig actually, the rfkill is intentionally a simple kernel->userspace
> notification. There are already various ways a interface can be disabled and
> adding more would in my opinion not be a good thing.
> The reason for a hardware key event is to do something additionally besides
> simply turning down the radio of the (registered interfaces) because he might
> have additional interfaces to be shutdown, or there has to be done something
> with the interface before the radio is switched off.
> 

Well, this assumes that you have a network interface which may not be the
case. For example I could have a bluetooth keyboard or mouse instead of
network card. And you are proposing a generic solution...

> > I would rather see you implemented a transmitter control framework
> > that would export couple of sysfs attributes. One attribute would
> > enable/disable controlling transmitter state automatically by the
> > driver and another  would allow controlling transmitter from
> > userspace. Then input device would always deliver events to userspace
> > (btw, it probably shoudl be switch, not a key event) and it would be
> > up to userspace program to explicitely take control over.
> 
> This can indeed be done, would it not also make the input device redundant?
> Since userspace could also just poll a sysfs entry, and I on the netdev list the
> input device seemed to be prefered over sysfs polling.
>

Input device is good since then userspace connects to all of them and
waits for that specific event. The key (or switch) may even be generated
by another device (for example reassigning a key on my AT keyboard).
But I would probably keep RF control and input device separate instead of
mixing into one abstraction layer.

-- 
Dmitry
