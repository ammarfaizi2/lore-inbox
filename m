Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWBGWF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWBGWF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbWBGWF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:05:56 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:62293 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030183AbWBGWFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:05:55 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Date: Tue, 7 Feb 2006 14:05:48 -0800
User-Agent: KMail/1.7.1
Cc: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>,
       "Andrew Morton" <akpm@osdl.org>, "Carlo E. Prelz" <fluido@fluido.as>,
       linux-kernel@vger.kernel.org
References: <0EF82802ABAA22479BC1CE8E2F60E8C3B01A40@scl-exch2k3.phoenix.com>
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C3B01A40@scl-exch2k3.phoenix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071405.49462.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 6:03 pm, Aleksey Gorelov wrote:
> Hi Dave,
> 
> >....
> >
> >I think what happened is the "always run quirks" code got turned into
> >the default too early, before the EHCI "quirk" version of the handoff
> >code got checked against what most systems have been using for the past
> >several years.
> >
> >I noticed at least one suspicous thing:  it enables an SMI IRQ.
> 
>   As far as I recall, some BIOSes can be stuck at handoff forever
> waiting for SMI if this is not enabled. No doubt BIOS bug, and seems
> like work around brakes some other systems, grrr...

I gathered as much and that's why I preserved that behavior.

But it would be nice to know _which_ BIOS versions have that bug;
it's clearly a BIOS bug, and given the other problems we've seen,
it might be better to have that "turn on the SMI" be keyed by some
"real" quirk logic or kernel parameters.

(The fact that USB handoff is being driven by "quirk" logic, even
when it's not a quirk, also raises little warning flags...)


> >Even in cases when the boot firmware says it's not using EHCI ...
>
>   That's what I do not understand. SOOE is enabled only if BIOS ownes
> EHCI - check for ECHI_USBLEGSUP_BIOS in previous 'if' statement. Am I
> missing something ?

That's how it works now, but it didn't do that before.  Previously it
always turned on the SMI, and then never turned it off, causing issues
on various platforms.

Of course, the BIOS that Carlo is struggling with seems terminally
broken, and is blatantly ignoring the spec for how those handoff
flags are supposed to work.

- Dave


