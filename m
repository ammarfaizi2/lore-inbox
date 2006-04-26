Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWDZKnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWDZKnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 06:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWDZKnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 06:43:06 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:22793 "EHLO
	smtp-vbr5.xs4all.nl") by vger.kernel.org with ESMTP id S932371AbWDZKnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 06:43:05 -0400
Date: Wed, 26 Apr 2006 12:43:01 +0200
From: bjdouma <bjdouma@xs4all.nl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Message-ID: <20060426104301.GA4634@skyscraper.unix9.prv>
References: <20060422204844.GA16968@skyscraper.unix9.prv> <d120d5000604250823p4f2ed2acv4287f7d70c71c7c0@mail.gmail.com> <20060425152600.GA30398@suse.cz> <200604260106.38480.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604260106.38480.dtor_core@ameritech.net>
X-Disclaimer: sorry
X-Operating-System: human brain v1.04E11
Organization: A training zoo
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 01:06:38AM -0400, Dmitry Torokhov wrote:

> What do you gius think about the patch below?

Works like a charm.
Why is it though that we need EVIOCSREP, when I can set PERIOD and
DELAY through writing a struct input_event directly to the file
descriptor?  I've been doing that for quite some time, having
softrepeat=1 (I need a quick keyboard, DELAY=120, PERIOD=18).

One typo in the patch:
+#define EVIOCSREP		_IOW('E', 0x03, int[2])			/* get repeat settings */
should be:
+#define EVIOCSREP		_IOW('E', 0x03, int[2])			/* set repeat settings */

Now, the EV_SND bitmap is still broken.
I don't think it's simply a matter of adding change_bit(code,dev->snd)
in the EV_SND part of input.c.  During a quick test the bitmap
became confused, after setting both bell and tone through writing
a struct input_event to the file descriptor of the pcspkr's event
file in /dev/input/, then setting just bell to 0.

bjd
