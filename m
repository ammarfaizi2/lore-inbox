Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263446AbRFAJ5i>; Fri, 1 Jun 2001 05:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263445AbRFAJ52>; Fri, 1 Jun 2001 05:57:28 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:3737 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S263444AbRFAJ5T>; Fri, 1 Jun 2001 05:57:19 -0400
Date: Fri, 1 Jun 2001 10:57:17 +0100
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <laughing@shared-source.org>
Subject: USB mouse wheel breakage was Re: Linux 2.4.5-ac5
Message-ID: <20010601105717.A2468@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <laughing@shared-source.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010530213039.A25251@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.18i
From: Michael <leahcim@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 09:30:39PM +0100, Alan Cox wrote:
> 2.4.5-ac4
> o	Update USB hid drivers				(Vojtech Pavlik)

I think these changes have broken my USB wheel mouse.

Events seems to be getting lost (/dev/input/mice)

It only scrolls when either the scroll direction has changed or if other
mouse events occur (e.g. you need to wiggle mouse from side to side to
scroll down a long page in mozilla)

problems seems to be in drivers/usb/hid-core.c hid_input_field line 772

	for (n = 0; n < count; n++) {

		if (HID_MAIN_ITEM_VARIABLE & field->flags) {

			if ((field->flags & HID_MAIN_ITEM_RELATIVE) && !value[n])
				continue;
The next 2 lines are dropping the scroll wheel events (which appear in the
input code as type:2, code: 8, value -1 or 1 depending on direction)

			if (value[n] == field->value[n])
				continue;
			hid_process_event(hid, field, &field->usage[n], value[n]);
			continue;
		}


Works fine in ac3.
-- 
Michael.
