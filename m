Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRIZCdY>; Tue, 25 Sep 2001 22:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274790AbRIZCdP>; Tue, 25 Sep 2001 22:33:15 -0400
Received: from zok.sgi.com ([204.94.215.101]:43137 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274789AbRIZCdD>;
	Tue, 25 Sep 2001 22:33:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org,
        Kristian Hogsberg <hogsberg@users.sourceforge.net>,
        linux1394-devel@lists.sourceforge.net
Subject: Re: Announce: modutils 2.4.9 is available 
In-Reply-To: Your message of "Wed, 26 Sep 2001 11:30:11 +1000."
             <3BB12FA3.96460B90@eyal.emu.id.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Sep 2001 12:33:18 +1000
Message-ID: <25245.1001471598@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001 11:30:11 +1000, 
Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>I just built and installed modutils-2.4.9.
>depmod: Unexpected value (20) in
>'/lib/modules/2.4.10/kernel/drivers/ieee1394/sbp2.o' for
>ieee1394_device_size
>        It is likely that the kernel structure has changed, if so then
>        you probably need a new version of modutils to handle this
>kernel.

struct ieee1394_device_id in the kernel does not match the layout in
the modutils ieee1394 patch from Kristian Hogsberg.  Kristian's patch
to me had an extra field at the end.  I suggest adding
	void *driver_data;
to the end of struct ieee1394_device_id in
drivers/ieee1394/ieee1394_hotplug.h.

Index: 10.1/drivers/ieee1394/ieee1394_hotplug.h
--- 10.1/drivers/ieee1394/ieee1394_hotplug.h Mon, 13 Aug 2001 14:14:10 +1000 kaos (linux-2.4/Q/e/44_ieee1394_h 1.1 644)
+++ 10.1(w)/drivers/ieee1394/ieee1394_hotplug.h Wed, 26 Sep 2001 12:32:33 +1000 kaos (linux-2.4/Q/e/44_ieee1394_h 1.1 644)
@@ -14,6 +14,7 @@ struct ieee1394_device_id {
 	u32 model_id;
 	u32 sw_specifier_id;
 	u32 sw_specifier_version;
+	void *driver_data;
 };
 
 #define IEEE1394_PROTOCOL(id, version) {				       \

