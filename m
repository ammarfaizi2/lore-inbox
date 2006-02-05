Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWBEUKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWBEUKb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 15:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWBEUKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 15:10:31 -0500
Received: from relay02.roc.ny.frontiernet.net ([66.133.182.165]:37006 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1750709AbWBEUKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 15:10:30 -0500
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/12] LED Class, Triggers and Drivers
Date: Sun, 5 Feb 2006 12:10:27 -0800
Message-ID: <001001c62a90$35171440$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1139154718.6438.78.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Purdie [mailto:rpurdie@rpsys.net]
>This is an updated version of the LED class/subsystem. The main change
>is the renamed API - I've settled on led_device -> led_classdev. Other
>minor issues like the error cases in the timer trigger were also fixed.

In the previous version 'frequency' for the timer trigger was actually
half the period of the oscillation - the time in ms between each (on/off)
state transition.

In this version 'frequency' is the frequency of the oscillation in Hz.

That creates a big problem for me because the value is parsed as an
integer and I can no longer achieve slow flash rates (<1Hz).  Since I
have to be able to do this I made a fairly crude patch to store the
frequency in mHz, not Hz, and to handle a decimal point in the value.

Possible fixes:

1) Use 'period' not 'frequency' and accept a value in ms (as before,
   but with the off-by-2 error corrected.)
2) Use 'mark' and 'space' or 'time_on', 'time_off' or something similar
   and remove 'duty' (I *do* need flashing with duty cycle != 0.5)
3) Accept fractional frequency (as in my patch).
4) Provide both period and frequency as integers and accept that
   long period flashs will come out as frequency '1' (but the period
   would still need to be in ms, because periods about 1500ms are of
   significant utility.)

John Bowler <jbowler@acm.org>

