Return-Path: <linux-kernel-owner+w=401wt.eu-S964902AbWL2F2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWL2F2F (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 00:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWL2F2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 00:28:05 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:7090 "EHLO
	asav09.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbWL2F2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 00:28:04 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAPM1lEVKhRO4UGdsb2JhbACOAAEBKg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Rene Herman <rene.herman@gmail.com>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
Date: Fri, 29 Dec 2006 00:28:01 -0500
User-Agent: KMail/1.9.3
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <4592E685.5000602@gmail.com> <200612290000.12791.dtor@insightbb.com> <4594A4DC.5090404@gmail.com>
In-Reply-To: <4594A4DC.5090404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612290028.01531.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 December 2006 00:17, Rene Herman wrote:
> Dmitry Torokhov wrote:
> 
> >>> The change to suppress ACKs from paic blinking is already in Linus's
> >>> tree. I just tried booting with root=/dev/sdg and I had leds blinking
> >>> but no messages from atkbd were seen.
> >>>
> >>> Could it be that you loaded older kernel by accident? Does anybody
> >>> else still seeing "Spurios ACK" messages during kernel panic?
> >> Well, no, I'm really on 2.6.20-rc2, from a freshly cloned tree. And I do 
> >> get atkbd.c complaining at me when I boot with root=/dev/wrong-device.
> >>
> >> Could you point me to the changeset in question? I couldn't find it 
> >> searching for "leds" in the log.
> >>
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=817e6ba3623de9cdc66c6aba90eae30b5588ff11
> 
> Yes, I do have that in my tree. From the looks of it it's probably not 
> surprising, but the following gets me blinking leds without the spurious 
> ACK messages. Maybe still useful to know?
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index debe944..9c70d34 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -371,7 +371,7 @@ static irqreturn_t i8042_interrupt(int i
>   	if (unlikely(i8042_suppress_kbd_ack))
>   		if (port_no == I8042_KBD_PORT_NO &&
>   		    (data == 0xfa || data == 0xfe)) {
> -			i8042_suppress_kbd_ack = 0;
> +			/* i8042_suppress_kbd_ack = 0; */
>   			goto out;

That would indicate that your keyboard generates multiple acks... I wonder
if you could boot with i8042.debug=1 and somehow capture the data flow
during panic (do you have a digital camera?).

-- 
Dmitry
