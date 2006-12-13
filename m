Return-Path: <linux-kernel-owner+w=401wt.eu-S965023AbWLMQnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWLMQnI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWLMQnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:43:07 -0500
Received: from mouth.voxel.net ([69.9.180.118]:48192 "EHLO mail.squishy.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965023AbWLMQnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:43:06 -0500
Message-ID: <45802D98.7030608@debian.org>
Date: Wed, 13 Dec 2006 11:43:04 -0500
From: Andres Salomon <dilinger@debian.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, warp@aehallh.com
Subject: Re: [PATCH] psmouse split
References: <457F822E.4040404@debian.org>	 <200612130108.19447.dtor@insightbb.com> <457FAA01.9010807@debian.org> <d120d5000612130612v5d12adc0uc878b8307770d79@mail.gmail.com>
In-Reply-To: <d120d5000612130612v5d12adc0uc878b8307770d79@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 12/13/06, Andres Salomon <dilinger@debian.org> wrote:
>> Dmitry Torokhov wrote:
[...]
>>
>> If a KVM requires a user to force a standard protocol, I would think
>> that forcing it via psmouse_attr_set_protocol would be a much nicer way
>> than dealing w/ max_proto.  Combine that w/ being able to rmmod specific
>> protocol modules (ie, rmmod psmouse-synaptics if it turns out that
>> detection is incorrectly seeing something synaptics-like).
>>
> 
> That requires changing your init scripts and such. In many instances
> specifying psmouse.max_proto on kernel command line is the easiest
> way.
> 

Init script changing shouldn't be necessary; we have module blacklist stuff.

For example, on an ubuntu system, we have:

/etc/modprobe.d/blacklist

psmouse-foo causing problems?  Just add it in there, and you're good.

I'm not aware of any way to specify values to be set in /sys (similar to
/etc/sysctl.conf), but I'm sure we'll get something sooner or later.

>>
>> > Also, splitting psmouse into several modules as opposed to having
>> monolitic
>> > psmouse with an option to exclude some protocols via Kconfig does
>> not really
>> > buy us anything - because protocol autoload is not possible (we do
>> not know
>>
>> It does; compiling a custom kernel for users is a pain.  However, using
>> a distribution kernel and being able to control specifically which
>> modules are loaded makes life a lot easier (users get security updates,
>> etc).
>>
>>
>> > what protocols port uses until we actually do the probe)
>> distributions will
>> > have to compile and load everything anyway. Custom kernel users will
>> just
>> > have to compile protocols they need into psmouse.
>> >
>>
>> Yes, distributions will have to compile and load everything anyways.
>> However, people who know what hardware they have can then force loading
>> of a specific module, rather than having a monolithic module or having
>> to recompile a custom kernel.
>>
> 
> I would consider this module juggling way over the head for average
> user. I want to have the ability to exclude some protocols from
> psmouse module via Kconfig option, but I want it to be hidden under
> CONFIG_EMBEDDED for everything except very raretic protocols (like
> OLPC).
> 

Alright, I guess we're down to a matter of taste then.  I'll change the
patch to still have a monolithic psmouse that allows protocols to be
enabled/disabled via Kconfig.

