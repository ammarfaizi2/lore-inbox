Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTL2REs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTL2REs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:04:48 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:15010 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263793AbTL2REn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:04:43 -0500
From: Duncan Sands <baldrick@free.fr>
To: "Guldo K" <guldo@tiscali.it>
Subject: Re: speedtouch for 2.6.0
Date: Mon, 29 Dec 2003 18:04:40 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <16366.61517.501828.389749@gargle.gargle.HOWL> <200312291714.10152.baldrick@free.fr> <16368.23199.717051.15982@gargle.gargle.HOWL>
In-Reply-To: <16368.23199.717051.15982@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_o6F8/UhxajOEAfe"
Message-Id: <200312291804.40544.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_o6F8/UhxajOEAfe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 29 December 2003 17:47, Guldo K wrote:
> Duncan Sands writes:
>  > Hi Guldo, from your email I had understood that your setup worked under
>  > 2.4.  Is that right?
>
> It's not. I didn't tell you that my previous setup (2.4)
> was about the user driver, not the kernel one.
>
>  > Anyway, the speedbundle (
>  > http://linux-usb.sourceforge.net/SpeedTouch/download/index.html
>  > ) contains source code for an appropriate pppd + ATM library.
>
> Thanks.
> I tried to compile just ppp, but "make" resulted in:

Yeah, I was a bit brief :)  Look in the top-level Makefile (in
speedbundle) to see how to compile.  The easiest thing to
do though is probably to use the attached top-level Makefile,
which is the same as the current one except that it doesn't
compile the kernel module.  I didn't test it but it should work.

Ciao,

Duncan.

--Boundary-00=_o6F8/UhxajOEAfe
Content-Type: text/x-makefile;
  charset="iso-8859-1";
  name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Makefile"

all: build

configure: configure-stamp
configure-stamp:
	./configure

build: configure-stamp build-stamp
build-stamp:
#	cd kernel_module && $(MAKE)
	cd linux-atm/src/lib && $(MAKE)
	cd ppp/pppd && $(MAKE)
	cd ppp/pppd/plugins && $(MAKE) C_INCLUDE_PATH=../../../linux-atm/src/include LIBRARY_PATH=../../../linux-atm/src/lib/.libs
	cd firmware && $(MAKE)
	cd firmware_loader && $(MAKE)
	cd hotplug_scripts && $(MAKE)
	cd ppp_scripts && $(MAKE)
	touch build-stamp

clean:
	rm -f build-stamp configure-stamp
	cd firmware && $(MAKE) clean
	cd firmware_loader && $(MAKE) clean
	cd hotplug_scripts && $(MAKE) clean
#	cd kernel_module && $(MAKE) clean
	cd linux-atm/src/lib && $(MAKE) clean
	cd ppp/pppd/plugins && $(MAKE) clean
	cd ppp/pppd && $(MAKE) clean
	cd ppp_scripts && $(MAKE) clean

install: build
#	cd kernel_module && $(MAKE) install
	cd firmware && $(MAKE) install
	cd firmware_loader && $(MAKE) modem_run
	cd hotplug_scripts && $(MAKE) install
	cd linux-atm/src/lib && $(MAKE) install
	cd ppp/pppd && $(MAKE) install
	cd ppp/pppd/plugins && $(MAKE) install
	cd ppp_scripts && $(MAKE) install

--Boundary-00=_o6F8/UhxajOEAfe--
