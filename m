Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVKOXSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVKOXSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVKOXSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:18:08 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:55586 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932552AbVKOXSH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:18:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KnWgw2dhahWq+gGhPz1+FtoLLVJl0vNCseU1tlzn9mYqIa1qiR1xzL8p7lQIpOzMShocE7qWgSDLWgSAunnIiQHvyY0dNzF17boyQwO08R/mrLOBqIUHgUm1NA5sKB/a4fRvrrD5tc9BsSrOtsGOy0IFDUI1EL+4LhuG5rDO8/0=
Message-ID: <d9def9db0511151518u10342e79r2a980683642051ff@mail.gmail.com>
Date: Wed, 16 Nov 2005 00:18:06 +0100
From: Markus Rechberger <mrechberger@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: snd_usb_audio
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

finally the em28xx driver made it into the kerneltree, but one problem
still remains
the snd_usb_audio driver.

the em28xx driver various framegrabber devices (pinnacle, hauppauge,
terratec,..).

The problem with the snd_usb_audio driver is that it only supports up
to 10 isochronous packets. If people watch TV using such a
framegrabber device and set audio to >8000hz the video isoc transfer
will break and the video will stop.

regarding usbaudio.c (in 2.6.14):
#define MAX_PACKS       10
#define MAX_PACKS_HS    (MAX_PACKS * 8) /* in high speed mode */

MAX_PACKS is the upper limit that is adjustable, the second one isn't
used at all

an easy hack would be to allow up to 100 packets but I also have a usb
1.1 soundblaster that might have problems with too many packets.

The correct value for em28xx devices is around 80 packets.

does anyone know more about the packet limitations on USB 1.1 and 2.0 devices?
MAX_PACKS_HS isn't used anywhere, but defined as MAX_PACKS * 8. I
don't know if it's just safe to say MAX_PACKS * 8 would fit for high
speed devices.

Unless this bug isn't fixed the em28xx driver is quite useless in the
kerneltree since it will not work with digital usb audio

Markus
