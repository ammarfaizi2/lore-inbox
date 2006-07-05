Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWGEPzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWGEPzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 11:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWGEPzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 11:55:35 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:54154 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964775AbWGEPze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 11:55:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xm3wPD0uB5bkY/opM4dKXICR9GFGXmmfnzQmxI98EKCmHywrRZYPX1MeQIGZhbhkGzYMNtlATmlS677wuZj/wZch0eywuZreYRcvDkGwZGpzJpDQ4wG8tjdDMLBfg388BoTtbNCPdKMQvynGMLq4pbsOwhLfHI+G9vnAzj3cTTc=
Message-ID: <e1e1d5f40607050855t5584178drfaeddfc78662a6bb@mail.gmail.com>
Date: Wed, 5 Jul 2006 11:55:33 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Bill Davidsen" <davidsen@tmr.com>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Greg KH" <greg@kroah.com>,
       "Alon Bar-Lev" <alon.barlev@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44AB3988.1050308@tmr.com>
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
	 <44AB3988.1050308@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Alan Cox wrote:
    > Ar Llu, 2006-07-03 am 18:11 -0400, ysgrifennodd Daniel Bonekeeper:
    >> That's one problem: I don't want to create one more userspace
    >> interface for that. I suppose that all the hundreds of fingerprint
    >> readers that ships with a SDK have their own way of doing that.. that
    >
    > The very cheap readers all appear to be fairly crude image scanners, and
    > they even lack hardware encryption/perturbation so they are actually of
    > very limited value.



As I said before, usefulness is something relative, and sometimes,
security is not a concern (even when talking about fingerprint
readers).
My intention with this is to try to create a catalog of fingerprint
readers' properties and I think that taking a look at vendors' SDKs
would be a good start.
As pointed out by Greg, it would be also interesting to export those
properties via sysfs instead of structure passing (or in addiction,
not sure yet).
I'm not sure though about relating fingerprint devices with V4L2 (even
the cheapest ones). Some other considerations discussed with Greg are
also:

1) extending those device informations to other classes, not only to
fingerprint readers
2) maybe using another layer to hold device properties based on
classes ( device driver -> device information layer -> sysfs+kobjects
) so we can have specific properties for "fingerprintreader" objects
and easier ways to export them to the sysfs layer, without explicit
declaration on the device driver
3) extend that layer also to non-USB devices ( bus-independent )

Maybe sysfs classes could have a list of default properties (for
example, /sys/class/fingerprint objects could hold a list of commom
fingerprint properties).


    Crude, like beauty, is in the eye of the beholder. I like hardware which
    does as little as possible because I can then apply the appropriate
    software to the data. I can see that if cost is no object and the
    algorithm is never going to change, I can build all that stuff into the
    device. But I don't need to... as long as I can take the data, pass it
    through a transform, and get out of that a key which works or not, then
    I can do useful things with it.

    Useful includes many things. I'm playing with using a combined secret
    and SecureID(tm) to decrypt and boot a virtual machine, such that I can
    do many unrelated things and have reduced chance of "unintended data
    migration." It also allows ad-hoc users (read that as undergrads) given
    a temporary machine fairly easily, visiting professors, etc.

    I can see the benefits of having the whole package be a black box, I
    hope I have explained why I find even a dumb scanner useful in some cases.

    --
    Bill Davidsen < davidsen@tmr.com >


Which fingerprint reader are you using ?

Daniel

PS: sorry about sending that message more than once, I just figured
out that my mails were boucing back to me because Gmail was using HTML
mode for mails =S

-- 
What this world needs is a good five-dollar plasma weapon.
