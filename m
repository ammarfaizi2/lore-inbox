Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTFMVC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbTFMVC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:02:27 -0400
Received: from maild.telia.com ([194.22.190.101]:22756 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S265531AbTFMVCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:02:25 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
References: <m2smqhqk4k.fsf@p4.localdomain> <20030611170246.A4187@ucw.cz>
	<m27k7sv5si.fsf@telia.com> <20030611203408.A6961@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 13 Jun 2003 23:15:57 +0200
In-Reply-To: <20030611203408.A6961@ucw.cz>
Message-ID: <m23cidllv6.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@ucw.cz> writes:

> On Wed, Jun 11, 2003 at 08:16:13PM +0200, Peter Osterlund wrote:
> 
> > The w value is somewhat special and not really a real axis. According
> > to the Synaptics TouchPad Interfacing Guide
> > (http://www.synaptics.com/decaf/utilities/ACF126.pdf), W is defined as
> > follows:
> > 
> > Value		Needed capability	Interpretation
> > W = 0		capMultiFinger		Two fingers on the pad.
> > W = 1		capMultiFinger		Three or more fingers on the pad.
> > W = 2		capPen			Pen (instead of finger) on the pad.
> > W = 3		Reserved.
> > W = 4-7		capPalmDetect		Finger of normal width.
> > W = 8-14	capPalmDetect		Very wide finger or palm.
> > W = 15		capPalmDetect		Maximum reportable width; extremely
> > 					wide contact.
> > 
> > Is there a better way than using ABS_MISC to pass the W information to
> > user space?
> 
> We should probably add an EV_MSC, MSC_GESTURE event type for this.
> That'll be the cleanest solution.

Peter Berg Larsen suggested in a private email that we shouldn't
export W directly, because it is too synaptics specific. Better split
it in "number of fingers" and "finger width", so that other touchpads
could use the same format.

What do we call these things? ABS_FINGER_WIDTH and ABS_NR_FINGERS
maybe?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
