Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292000AbSCEBGe>; Mon, 4 Mar 2002 20:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293096AbSCEBGY>; Mon, 4 Mar 2002 20:06:24 -0500
Received: from razor.hemmet.chalmers.se ([193.11.251.99]:26499 "EHLO
	razor.hemmet.chalmers.se") by vger.kernel.org with ESMTP
	id <S292000AbSCEBGO>; Mon, 4 Mar 2002 20:06:14 -0500
Message-ID: <3C8419FF.10103@kjellander.com>
Date: Tue, 05 Mar 2002 02:06:07 +0100
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a computer with four USB ports, one UHCI-controller on the
motherboard and three OHCI PCI-cards from Lucent Technologies (can't
get the exact make and model until tomorrow, no physical access right now).

Attached to each one of these is an Philips ToUCam pro which uses the pwc
and pwcx modules. (yes, the kernel becomes tainted by the pwcx module)

The camera attached to the UHCI-controller running usb-uhci works just fine,
but the three attached to the OHCI-controllers running usb-ohci don't. After
a random amount of frames being read from a camera the read()-call blocks
indefinitely until the device is closed. Next time the v4l-device is opened
the program can again read frames from the camera but read() always blocks
after some time.

The amount of frames that are successfully read can range from 50 to a
couple of thousand, the amount seems to be totally random. There are no
messages in the logs of any kind when the blocking occurs. It happens with
both read() and mmap(), always on the usb-ohci cards and never on the
usb-uhci onboard controller.

Since we have never seen this problem with these cameras, and we've been
using them for well over a year, so I don't think it is a bug in pwc.o. It
could be flaky hardware, in which case usb-ohci should have a workaround.
It could be that some of the cards are sharing IRQ's but one of the cards
has a differant one, and the UHCI is on the same IRQ as two of the OHCI
cards.

The most probable is that there is a bug somewhere in usb-ohci since we
only see the behaviour with this card/driver combination, or that the
cards are crap.

I've tried both 2.4.17 and 18 with the same result.

The only thing in dmesg is:
pwc Iso frame 1 of USB has error -18

But these messages occur without read() blocking most of the times.

Is there any way to get more info on what is going on in usb-ohci?

/Carl-Johan Kjellander
please Cc me as I'm not subscribing to the list.
-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`

