Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbVJRI05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbVJRI05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 04:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVJRI05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 04:26:57 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:44940 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1751468AbVJRI04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 04:26:56 -0400
Message-ID: <4354B1D1.4060802@ens-lyon.org>
Date: Tue, 18 Oct 2005 10:26:57 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.14-rc4-mm1
References: <20051016154108.25735ee3.akpm@osdl.org> <43539762.2020706@ens-lyon.org> <20051017132242.2b872b08.akpm@osdl.org> <20051018065843.GB11858@kroah.com> <4354A49B.6060809@ens-lyon.org> <20051018074029.GC12406@kroah.com>
In-Reply-To: <20051018074029.GC12406@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18.10.2005 09:40, Greg KH a écrit :
> If you disable CONFIG_PNP, does the oops go away?
> 
> Also, does this oops keep you from booting?  If not, can you see what
> the output of 'cat /proc/bus/input/devices' produces (it should show
> what device is dying on us.)

Yes disabling CONFIG_PNP makes it disappear.

Here comes /proc/bus/input/devices from 2.6.14-rc4:

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0
B: EV=120013
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7

I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio4/input0
H: Handlers=mouse0 event1
B: EV=b
B: KEY=6420 0 70000 0 0 0 0 0 0 0 0
B: ABS=11000003

I: Bus=0011 Vendor=0002 Product=000a Version=0000
N: Name="TPPS/2 IBM TrackPoint"
P: Phys=synaptics-pt/serio0/input0
H: Handlers=mouse1 event2
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
H: Handlers=kbd event3
B: EV=40001
B: SND=6

Without CONFIG_PNP, the last one disappears.

In rc4-mm1, the last one is a little bit different
(Name and Phys fields):

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="isa0061/input0"
P: Phys=
S: Sysfs=/class/input_dev/input3
H: Handlers=kbd event3
B: EV=40001
B: SND=6

Brice
