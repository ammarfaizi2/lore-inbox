Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265888AbUAKODK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUAKOA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:00:28 -0500
Received: from hera.cwi.nl ([192.16.191.8]:25016 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265882AbUAKN6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:58:23 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 11 Jan 2004 14:58:18 +0100 (MET)
Message-Id: <UTC200401111358.i0BDwIM08113.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, sven.kissner@consistencies.net
Subject: Re: logitech cordless desktop deluxe optical keyboard issues
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > That is a kernel message, not showkey output.
    > (BTW - which kernel precisely? The message is not the 2.6.0 one.)
    > Maybe showkey -s never sees them?

    i'm running a vanilla 2.6.1-kernel, without any additional patches.
    you're right about the message, showkey is exiting after 10s, even
    if i keep one of the 'problematic' keys pressed..

Yes, I see. Looking at 2.6.1 things are a bit different again,
but raw mode is very broken. Instead of reporting what the
keyboard sends, as raw mode is supposed to do, the scancode
is first converted to a keycode, and in the case of an unknown
scancode it is then just thrown away. In raw mode the keycode
is later translated back to a scancode (using a correspondence
that is not 1-1), but in your case we never get that far.

Did you try using setkeycodes? Say

# setkeycodes 91 120 92 121

to map scancode 0x91 to keycode 120 and 0x92 to 121.

Andries
