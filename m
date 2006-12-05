Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966430AbWLEW7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966430AbWLEW7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966586AbWLEW7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:59:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51218 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966430AbWLEW73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:59:29 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       Peter Stuge <stuge-linuxbios@cdy.org>,
       Stefan Reinauer <stepan@coresystems.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, "Lu, Yinghai" <yinghai.lu@amd.com>,
       Andi Kleen <ak@suse.de>, linuxbios@linuxbios.org
Subject: Re: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
	<m13b7xf084.fsf@ebiederm.dsl.xmission.com>
	<m1hcwcuu17.fsf_-_@ebiederm.dsl.xmission.com>
	<200612042001.09808.david-b@pacbell.net>
Date: Tue, 05 Dec 2006 04:18:30 -0700
In-Reply-To: <200612042001.09808.david-b@pacbell.net> (David Brownell's
	message of "Mon, 4 Dec 2006 20:01:08 -0800")
Message-ID: <m1fybu7fqx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell <david-b@pacbell.net> writes:

> On Sunday 03 December 2006 9:09 pm, Eric W. Biederman wrote:
>>
>> My driver should be sufficient to work with any EHCI in a realatively
>> clean state, and needs no special BIOS support just the hardware.
>> This appears to be different than the way the windows drivers are
>> using these debug devices.
>
> I'm glad to see someone finally got progress on this ... :)
>
> Separately, I forwarded some stuff I did last year ... maybe it'll help.
> You seem to have gotten further.  Have you also observed that the
> NetChip device seems to have polarity issues, such that only one
> end behaves properly?

I haven't yet.  But I don't think I have actually tried turning
the cable around in a very meaningful way yet either.  Possibly
this is something that has been fixed.  I know there are some
odd issues that I have encountered.  Like occasionally I would
need to stop the software on one side, or I would need to unplug
it when things got sufficiently confused.

> Note that this should **NOT** be specific to x86_64, since pretty
> much any PCI based EHCI can do this.  I wouldn't be able to use
> this on my NForce2 box, for example ...

So I took a quick look what it would take to do this truly generically
and even initializing this generally when console code typically
is registered looks like a problem.  Although only because we don't
get around to setting up pci_config space access helpers in a timely
manner.  To some extent that still sucks because you are still being
initialized before the general ehci-hcd code.

Regardless an arch specific i386 variant was easy to throw together.
It still needs a bit of work but it basically worked.

> As for EHCI registers, if this really _needs_ to live outside
> of drivers/usb/host, then I'd suggest <linux/usb/ehci.h> for
> the relevant declarations ... the <linux/usb/*.h> headers are
> provided exactly for sharing such declaration between otherwise
> unrelated parts of the tree.

Yep that sounds like the right thing to do.  I think I at least
need to be called from something outside of drivers/usb and may
need the code there.

Doing this in a truly generic fashion looks like a major pain.
Because all of the infrastructure needs to be fixed.

Eric
