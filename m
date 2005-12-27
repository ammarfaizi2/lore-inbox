Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVL0WSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVL0WSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 17:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVL0WSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 17:18:03 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:51668 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932358AbVL0WSB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 17:18:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tH9mi5/zdai6cPDnojSxTYTaWluMtjhlMfZyTmWUUU/HENT3vFyixKf/3zBEF0tfvTpQqIHAb685pyQ6JVAAbSEVNel7tdvNfMQg0KcRHQwDTfbIeebSXKxdpXTl/btRXcl5lkDq4bG/Z1U6WoaQu2fTWq4BwiK7KjdC58Td1fg=
Message-ID: <d120d5000512271418m26d3da41s18a3f97470eda912@mail.gmail.com>
Date: Tue, 27 Dec 2005 17:18:00 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [RFT] Sonypi: convert to the new platform device interface
Cc: LKML <linux-kernel@vger.kernel.org>, Stelian Pop <stelian@popies.net>
In-Reply-To: <Pine.LNX.4.61.0512271859240.3068@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512130219.41034.dtor_core@ameritech.net>
	 <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
	 <Pine.LNX.4.61.0512252207020.15152@yvahk01.tjqt.qr>
	 <200512251617.09153.dtor_core@ameritech.net>
	 <Pine.LNX.4.61.0512271859240.3068@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/05, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> It does not work here on a SONY VAIO U3. After loading the sonypi module,
> >> neither mev nor showkey return something for the special stuff like
> >> jogwheel, jogbutton or Fn keys respectively.
> >>
> >> Running 2.6.15-rc7, this appeared in the kernel log:
> >> Dec 25 22:06:14 takeshi kernel: sonypi: request_irq failed
> >
> >Just in case I am sending corrected patch.
> >
> Ok now it works. (Just like with the old sonypi :-)
>

The issues enumerated below are existed before my patch, did I
understand this correctly?

> However, there are some things that remain unresolved:
> - the "mousewheel" reports only once every 2 seconds when constantly
>  wheeling (in mev)
> - pressing the jogdial button produces a keyboard event (keycode 158)
>  rather than a mousebutton 3 event
>

158 is KEY_BACK and is generated on type2 models.. If you load the
driver with verbose=1 what does it say when you press jog dial?

> BTW, how can I use the Fn keys on console (keycodes 466-477) for arbitrary
> shell commands?
> Such a feature, among which special combinations like Ctrl+Alt+Del also
> belong, are handled by the kernel which leaves almost no room for
> user-defined userspace action. Any idea?
>

There are daemons that read corersponding /dev/input/eventX and act on
it. The in-kernel keyboard driver ignores keycodes above 255.

--
Dmitry
