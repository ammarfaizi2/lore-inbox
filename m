Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVCOAo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVCOAo4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVCOAoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:44:44 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:30158 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262151AbVCOAmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:42:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pUoolY25wF65MwQb7Tc9/nDRWDBW/0uSHBzRK+4cK9bF11m+prh5BDDKe7HADgzwgVne/LxAY3QGynOZGrNJOLKwjpZib0LIRMODAih+GTdsDxCRug2B9oEoLkPoc7r5ofXJPHFJjQU2U8RA3gyxe0nCobhG1+iBK+LbRK1FgII=
Message-ID: <d120d5000503140659501bc832@mail.gmail.com>
Date: Mon, 14 Mar 2005 09:59:19 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stephen Evanchik <evanchsa@gmail.com>
Subject: Re: [PATCH 2.6.11] IBM TrackPoint support
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <a71293c205031405403b353f6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a71293c2050313210230161278@mail.gmail.com>
	 <20050314081949.GA2309@ucw.cz>
	 <a71293c205031405403b353f6e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 08:40:22 -0500, Stephen Evanchik <evanchsa@gmail.com> wrote:
> On Mon, 14 Mar 2005 13:19:56 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > How much does it interpret the stream in non-transparent mode? Are
> > commands also passed through in soft transparent mode?
> >
> > I'm asking because we might want to implement a passthrough port
> > similarly to what the Synaptics driver does and allow extended protocol
> > mice to be connected to the external mouse port.
> 
> I originally thought that I could implement something similar to the
> Synaptics driver. Unfortunately, while in transparent mode bytes are
> relayed unmodified with the TrackPoint controller disabled. In other
> words, no simultaneous usage.
> 
> That doesn't mean extended protocol mice couldn't be supported in
> transparent mode however. I didn't find it particularly useful given
> the TrackPoint itself would be disabled.
> 

Here is my take on it (now that I have skimmed the TrackPint spec) -
transparent mode is to be used only when querying the external device.
This way trackpoint does not interfere with data stream at all and the
kernel gets a chance to know exactly whta is behing the trackpoint -
Logitech, explorer, something more exotic... Once identification is
done transparent mode should be cancelled.

Bit 3 can be used to de-multiplex 2 streams; hopefully trackpoint is
able to rely packets longer than 3 bytes from the external device.

As far as I can see there is no point of exporting transparent mode to
the userspace via sysfs. I also do not think that we need to export
middle_button_disable as it is "..for compatibility with older
software expecting this bit be always 0" and we do not have such an
issue. Also, if we implement pass-through port, then ext_dev is also
not needed since user can either unbind the driver from pass-through
port or just ignore the secondary input device in his/her config.

-- 
Dmitry
