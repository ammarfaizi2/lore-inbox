Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWHaPYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWHaPYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWHaPYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:24:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:54125 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751649AbWHaPX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:23:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=fLHFeHFIrXcs88Bk3TCQG5EfAp+padXUyISMUMeVuBEJSqkWNR/ecwWjO2e6+CZU2/BKTJiG/dTe6PNm2/O3onKf/qLo2YjeVh7iHEfVWIiskRF39hjaHfc/BkFt63VJGGxV/zu/sHuo9XRqnC4dPHsuNGVJNq7GuFFi618zUOk=
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] RFKILL - Add support for input key to control wireless radio
Date: Thu, 31 Aug 2006 17:23:47 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>
References: <200608271534.58503.IvDoorn@gmail.com> <200608282215.14480.IvDoorn@gmail.com> <200608302305.41075.dtor@insightbb.com>
In-Reply-To: <200608302305.41075.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311723.48151.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > I am not sure if this is a correct approach, kernel should not assume
> > > that the reason why input device was opened is to control the state of
> > > the transmitter. For example one could be happy with hardware toggling
> > > the state but still want to have for example a GKrellm showing state
> > > of the transmitter.
> > 
> > Valid point, but when the radio is disabled a wireless interface should
> > report a txpower of 0. I don't know if this is also the case for bluetooth or irda..
> > 
> 
> Exactly...
> 
> > > Also please explain how userspace would control the state of
> > > transmitter once KEY_RFKILL is received - there seems to be only
> > > kernel->userspace link, but not userspace->kernel.
> > 
> > Plain ifconfig actually, the rfkill is intentionally a simple kernel->userspace
> > notification. There are already various ways a interface can be disabled and
> > adding more would in my opinion not be a good thing.
> > The reason for a hardware key event is to do something additionally besides
> > simply turning down the radio of the (registered interfaces) because he might
> > have additional interfaces to be shutdown, or there has to be done something
> > with the interface before the radio is switched off.
> > 
> 
> Well, this assumes that you have a network interface which may not be the
> case. For example I could have a bluetooth keyboard or mouse instead of
> network card. And you are proposing a generic solution...

Correct me if I am wrong, but a IRDA and Bluetooth device will still have
userspace representation with a standard userspace tool right.
And with such a tool it would be normal to have a on/off switch for the radio
I would expect (and would find strange if such a switch is not there)
I have never used bluetooth or IRDA device so I can't talk from
experience here.

> > > I would rather see you implemented a transmitter control framework
> > > that would export couple of sysfs attributes. One attribute would
> > > enable/disable controlling transmitter state automatically by the
> > > driver and another  would allow controlling transmitter from
> > > userspace. Then input device would always deliver events to userspace
> > > (btw, it probably shoudl be switch, not a key event) and it would be
> > > up to userspace program to explicitely take control over.
> > 
> > This can indeed be done, would it not also make the input device redundant?
> > Since userspace could also just poll a sysfs entry, and I on the netdev list the
> > input device seemed to be prefered over sysfs polling.
> >
> 
> Input device is good since then userspace connects to all of them and
> waits for that specific event. The key (or switch) may even be generated
> by another device (for example reassigning a key on my AT keyboard).
> But I would probably keep RF control and input device separate instead of
> mixing into one abstraction layer.

Ok, that would make sense. I'll try to add the sysfs attributes you recommended.
I'll also have to add bluetooth/irda/bluetooth message seperation, since
at the moment pressing the wifi button for example would also
disable bluetooth devices and that is likely not desired by the users, (I already have
received objections about it, with requests to change that behaviour)

Ivo
