Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUAHP66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUAHP66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:58:58 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:56764 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265148AbUAHP64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:58:56 -0500
Date: Thu, 8 Jan 2004 15:57:53 +0000
From: Dave Jones <davej@redhat.com>
To: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIS 648FX AGP fixed - but clarification needed
Message-ID: <20040108155753.GB20616@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Heilmann, Oliver" <Oliver.Heilmann@drkw.com>,
	linux-kernel@vger.kernel.org
References: <1073563512.502.66.camel@cobra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073563512.502.66.camel@cobra>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 12:05:12PM +0000, Heilmann, Oliver wrote:

 > 1. According to sis_agp_device_ids the 648 chipset is supported. Does
 > this mean that the "plain" 648 is actually supported and my "FX"
 > iteration is so fundamentally different (even thought is has the same
 > device id).

Some of the agpgart submissions go along the lines of..
- agpgart complains when I load it.
- running with try_unsupported makes the error go away
- ID of chipset gets added.

In quite a few cases in the past, no, or little actual testing to see
whether the device works correctly, or doesn't corrupt mappings through
the GART.  In some cases, folks actually have thought everything was working
fine, and then later found out they had misconfigured their X setup, and
were running unaccelerated software GL.

These days when recieving ID updates, I usually ask folks
to at least give it a run through testgart to make sure.

It's not the be all and end all of test apps, but it catches the really
stupid cases.

 > 2. Once the agpEnable bit is set in the bridge's cmd register the config
 > space of the master is completely screwed up for a while. Trying to
 > configure/enable the master during that period mostly crashes the
 > system. Waiting does the trick. (Annoyingly, simply waiting for the
 > master to become readable again is not good enough, one still needs to
 > wait longer for things to become stable). None of the other chipsets
 > seem to need this. Can anybody explain? Perhaps I missed something? If
 > there is no other way and I do have to stick with the delay, then I
 > suppose it would not be a good idea to polute the generic agp_enable
 > with it?!
 
This sounds very odd. How long a delay are we talking here?
It sounds to me like we should be waiting on some other event.
I'll see if I can dig out the 648 datasheet later.

I'd rather not add it to agp_enable. Better would be to add a sis specific
.enable function (which mostly just calls the agp_generic_enable() function
and does the wait), so the other drivers don't need to worry about this.

I'd rather get to the bottom of why the delay is needed though.

		Dave

