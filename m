Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWBUVQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWBUVQB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWBUVQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:16:00 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:23128 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932789AbWBUVP7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:15:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KPRYc9+BiPBwHWrra+SfeBhc5RlQhUI60VILdY11w2O9RYt3g9WBj4ODnyQ4vXy/44RA6tsgBhjlKPkksmqU3Bf1TAT015BlJXKiqyLI98ahSxHARo/JCCI5979Z322CbI2FMdYPnVfLoJxXMp3NMVD0WWYqpp98Ha0aCzmVJKU=
Message-ID: <d120d5000602211315y60ad2861n4cd64535f9f4850d@mail.gmail.com>
Date: Tue, 21 Feb 2006 16:15:57 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Pete Zaitcev" <zaitcev@redhat.com>
Subject: Re: Suppressing softrepeat
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, stuart_hayes@dell.com
In-Reply-To: <20060221124308.5efd4889.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060221124308.5efd4889.zaitcev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Pete Zaitcev <zaitcev@redhat.com> wrote:
> Hi, Dmitry,
>

Hi Pete,

> Dell people passed on a request to add a new parameter, "nosoftrepeat",
> to i8042 (in atkbd.c). So, if I understand right, things should work so:
>
>  - None set in grub.conf: Softrepeat is set by the driver as detected
>   or derived. This is the default.
>  - "softrepeat" set: Softrepeat is on, regardless
>  - "nosoftrepeat" set: Softrepeat is off, regardless
>  - Both "softrepeat" and "nosoftrepeat" are set: Do not do that.
>
> The code looked confusing, but there is an good explanation in this bug:
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181457
>
> In short words, DRAC3 "plugs into" the keyboard connector, but does not
> emulate output, so we detect this as "dumb" keyboard and enable softrepeat.
> But softrepeat causes double keypresses.

I see the problem but I don't think we want another module parameter
for it. I think if you put the following somewhere into init scripts
it shoudl work without any additional changes:

        echo -n "0" > /sys/bus/serio/devices/serioX/softrepeat

Of couurse one would jhave to locate proper serioX but that should be easy.

I also see the following in bugzilla: "... This causs a problem on
systems that have no real keyboard plugged in, since atkbd probes for
the keyboard, and won't take control of the port if it doesn't see
one." Usually it is OK for keyboard to be missing as long as BIOS
itself does not disable keyboard port - whenever there is new data
starts coming from the port serio core will try to find proper driver
for it. I wonder why this is not working on boxes in question.

--
Dmitry
