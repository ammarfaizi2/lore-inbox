Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269174AbTCBKRf>; Sun, 2 Mar 2003 05:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269176AbTCBKRf>; Sun, 2 Mar 2003 05:17:35 -0500
Received: from mail.tbdnetworks.com ([63.209.25.99]:52123 "EHLO
	tbdnetworks.com") by vger.kernel.org with ESMTP id <S269174AbTCBKRd>;
	Sun, 2 Mar 2003 05:17:33 -0500
Date: Sun, 2 Mar 2003 02:27:51 -0800
To: linux-kernel@vger.kernel.org
Subject: Multiple & vs. && and | vs. || bugs in 2.4 and 2.5
Message-ID: <20030302102751.GA26028@defiant>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
inspired by the recent bug report from Muli Ben-Yehuda (see
http://marc.theaimsgroup.com/?l=linux-kernel&m=104647477025930), I
hunted for similar bugs in 2.4 and 2.5 using a simple grep:

find ${1:-.} -name \*.c | xargs grep -En '![a-zA-Z0-9_ ]+(\|[^|]|\&[^&])|([^|]\||[^&]\&) *!'

This found typos in both 2.4.20 and 2.5.63.  Please note that is a
trimmed down list of the grep, I removed what I considered false
positives (e.g. real bit operations and matches within comments).  All
but the trident.c typo looks like a logical and not a bit operation to
me.

linux-2.4.20/drivers/net/aironet4500_core.c:2679:	if (adhoc & !max_mtu)
linux-2.4.20/drivers/sound/gus_midi.c:186:	return (qlen > 0) | !(GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY);
linux-2.4.20/drivers/sound/gus_wave.c:3126:	if ((gus_mem_size > 0) & !gus_no_wave_dma)
linux-2.4.20/drivers/sound/maestro.c:3362:	if(! w & PCI_STATUS_CAP_LIST) return 0;
linux-2.4.20/drivers/sound/trident.c:3063:		if(!wcontrol & 0x8000)
linux-2.4.20/drivers/video/aty128fb.c:2534:		if (!reg & LVDS_ON) {
linux-2.4.20/drivers/video/radeonfb.c:2781:		if (!lvds_gen_cntl & LVDS_ON) {
linux-2.4.20/drivers/usb/acm.c:243:	if (!urb->status & !acm->throttle)  {
linux-2.4.20/drivers/i2c/i2c-proc.c:732:			       SENSORS_ANY_I2C_BUS) & !is_isa))
linux-2.4.20/drivers/i2c/i2c-proc.c:821:			       probe[i] == SENSORS_ANY_I2C_BUS) & !is_isa))
linux-2.4.20/drivers/i2c/i2c-proc.c:838:			       SENSORS_ANY_I2C_BUS) & !is_isa))

linux-2.5.63/drivers/media/dvb/dvb-core/dvb_demux.c:224:	if (f->doneq & !neq)
linux-2.5.63/drivers/video/console/fbcon.c:459:	if (rw & !bottom_only) {
linux-2.5.63/drivers/serial/uart00.c:238:	if (!status & (UART_MSR_DCTS_MSK | UART_MSR_DDSR_MSK | 
linux-2.5.63/drivers/pnp/pnpbios/core.c:325:	if ( !boot & pnpbios_dont_use_current_config )
linux-2.5.63/drivers/pnp/pnpbios/core.c:353:	if ( !boot & pnpbios_dont_use_current_config )
linux-2.5.63/net/sctp/tsnmap.c:249:	if (started & !ended) {
linux-2.5.63/sound/oss/gus_midi.c:182:	return (qlen > 0) | !(GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY);
linux-2.5.63/mm/slab.c:1646:		if (!flags & __GFP_WAIT)

Should I create patches for these and send them to the maintainers?

so long
	Norbert

