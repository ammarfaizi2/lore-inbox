Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWGCWtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWGCWtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWGCWtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:49:17 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:47574 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932168AbWGCWtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:49:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BzPzHH1UDTmwnUssngj9UxcflBkTZWmyKrLyfg5mqLcDE+lu8GToswhp+mMnRDvDAwm/SBB1dzuxtcJbbYRKner7mTthvpLDl19UxUy3ejtU/uZQ2nv2aM8/I7uSUmQfEMwBQD7APrOyxM8TGW0kEL1gafCZwTqBInD0FX4u6Vg=
Message-ID: <e1e1d5f40607031549w734c82f4h28bb887709c32f44@mail.gmail.com>
Date: Mon, 3 Jul 2006 18:49:12 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Greg KH" <greg@kroah.com>, "Alon Bar-Lev" <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
In-Reply-To: <1151966154.16528.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>
	 <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>
	 <44A95F12.8080208@gmail.com>
	 <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>
	 <20060703214509.GA5629@kroah.com>
	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
	 <1151966154.16528.42.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-03 am 18:11 -0400, ysgrifennodd Daniel Bonekeeper:
> > That's one problem: I don't want to create one more userspace
> > interface for that. I suppose that all the hundreds of fingerprint
> > readers that ships with a SDK have their own way of doing that.. that
>
> The very cheap readers all appear to be fairly crude image scanners, and
> they even lack hardware encryption/perturbation so they are actually of
> very limited value.
>

Noticed that. Well, which device to use is a decision of the user and
the kernel should be able to handle his needs, independently from
being the most secure or not.

> > looks awfull to me, even though I believe that currently there isn't
> > any uniform way of working with fingerprint readers... shouldn't we
> > have a way to classify devices ? For example, if I want to list all
>
> They vary from "low res bitmap" and the rest in software through "low
> res bitmap mangled by specific device instance unique scheme" (1)
> through to smart card based external tamperproof boxes that authenticate
> the smartcard with the fingerprint and the host typically via PAM in
> user space.
>
> That's a huge range of devices with little in common.
>

=(
At least they have something in common: all of them deliver an image
as output. Maybe that could be centralized somehow... for example, a
single structure that we use to ask for the capabilities of a fp
reader and the driver fills it telling the maximum resolution of
image, if it supports encryption or not (or if the datastream that
comes from the driver is encrypted or not), etc. What the userspace
does with the image is irrelevant. Let's imagine that: I have a daemon
in userspace that is responsible for reading fingerprints from
/dev/fingerprint[012], and it is supposed to be device-independent. So
this device asks the device for information about its capabilities,
and the device returns the information as a structure (for example
telling the dimension of the image returned, the image format, etc).

How does encryption-based readers works ? I suppose that a software
driver or library in userspace should be responsible for decrypting
the image and processing it, right ? So, in this case, the decryption
could be done at kernel level (to fit the model above, where just
images are returned), or giving the option for the userspace to
receive the raw encrypted stuff.

> Alan
> (1) Think about what happens if you don't have this. Its possible to
> steal a result then reverse engineer a "finger" on your own laptop to
> produce the same result.
>

At some point, the encrypted image needs to be decrypted for
processing, so it can be stolen anyways, right ?
