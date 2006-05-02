Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWEBVkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWEBVkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWEBVkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:40:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:6371 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964985AbWEBVkN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:40:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g9nTImNd0OcHhbrUs9KIj/S4F7bSmWxxGndFp03LYFFSLRlVm3n84J7Av+Pd/Oq73WHyaUfeieXTddgicDhtUtnwyV0Weiak3QDTHDNqK0U4iSUBbPjnmYTwptMryobL8ycZZ8jvuIByaIZYlB0s8zDoQO37Zq3tAo8HkCUvl04=
Message-ID: <21d7e9970605021440s6cdc3895t57617e5fad6c5050@mail.gmail.com>
Date: Wed, 3 May 2006 07:40:12 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Arjan van de Ven" <arjan@linux.intel.com>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, pjones@redhat.com, akpm@osdl.org
In-Reply-To: <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
	 <44578C92.1070403@linux.intel.com>
	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
	 <44579028.1020201@linux.intel.com>
	 <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
	 <1146594457.32045.91.camel@laptopd505.fenrus.org>
	 <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Allowing user space control of a device without a mechanism to assign
> ownership of the device is a very bad idea. There is no way for one
> user space program to tell if another is messing with the device.
> There has to be a mechanism like opening the device to indicate which
> process owns the device and is allowed to set their state into it (for
> states that can conflict, enabling the device is definitely a state
> that can conflict).

Jon stop being so dramatic, this is just like letting userspace map
the BARs, without ownership through sysfs, which is a good thing, you
can still map /dev/mem, look we have lots of ways to shoot ourselves
in the foot, if we *want* to.

> The rule needs to be that if you want to use a device it has to have a
> driver. Anything else results in chaos. It doesn't matter if these
> drivers have a tiny API, their purpose is to control ownership of the
> hardware.

Again we can already bypass device drivers.... so don't worry so much....

This attribute allows us to enable devices that X otherwise would hand
enable, that's all, it doesn't allow a user with vi to do it ....

> You may call this silly but it is a real pain to spend hours debugging
> code only to discover that it failed because some other app unknown to
> you altered the state of the hardware while you were using it.
>

Again we have lots of ways for this to happen...

Now X is stupid don't get me wrong and sorry Bjorn it might still
enable/disable devices it doesn't use (unless configured with some
arcania in xorg.conf), but this at least is step 1, this should allow
me to remove all the PCI BAR modfiying code from the Linux code paths,
and to be honest that is a very good start, we still need some sort of
VGA arbitration (which is why X actually messes with cards it doesn't
know about, as it has to make sure everyone isn't decoding the VGA
IOs...)

Dave.
