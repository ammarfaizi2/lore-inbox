Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbVLLDur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbVLLDur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 22:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVLLDur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 22:50:47 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:36781 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751074AbVLLDuq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 22:50:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Mouse stalls with 2.6.5-rc5-mm2
Date: Sun, 11 Dec 2005 22:50:44 -0500
User-Agent: KMail/1.9.1
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <9a8748490512110548h22889559ld81374f2626c3ed2@mail.gmail.com> <200512111327.40578.dtor_core@ameritech.net> <9a8748490512111149l358f18abuc7f0685413f75c06@mail.gmail.com>
In-Reply-To: <9a8748490512111149l358f18abuc7f0685413f75c06@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512112250.44848.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 14:49, Jesper Juhl wrote:
> well, unplugging the mouse from the KVM and plugging it into the PC's
> PS/2 port directly resulted in this in dmesg :
> 
> [  567.297724] psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost
> synchronization, throwing 1 bytes away.
> [  567.807251] psmouse.c: resync failed, issuing reconnect request
> [  568.015721] logips2pp: Detected unknown logitech mouse model 87
> 
> and after that I see no more resync failed messages and the mouse doesn't stall.
> 

Ok, so your KVM fakes the response to POLL command. But normally
(with resync disabled) your mouse works just fine with your KVM,
you can still use wheel after switching between the boxes, right?
If so I will try adjusting my patch.

In the mean time could you please try the tiny patch below - it
shoudl get rid of "unknown logitech mouse" message. Could you send
me your dmesg after applying the patch?

Thanks!

-- 
Dmitry

Subject: logips2pp: add signature of MouseMan Wheel Mouse (87)

Input: logips2pp - add signature of MouseMan Wheel Mouse (87)

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/logips2pp.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/mouse/logips2pp.c
===================================================================
--- work.orig/drivers/input/mouse/logips2pp.c
+++ work/drivers/input/mouse/logips2pp.c
@@ -228,6 +228,7 @@ static struct ps2pp_info *get_model_info
 		{ 83,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 85,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 86,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
+		{ 87,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 88,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 96,	0,			0 },
 		{ 97,	PS2PP_KIND_TP3,		PS2PP_WHEEL | PS2PP_HWHEEL },
