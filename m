Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUKCBER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUKCBER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbUKCBER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:04:17 -0500
Received: from smtp-out.hotpop.com ([38.113.3.71]:55453 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261433AbUKBVk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:40:27 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
Date: Wed, 3 Nov 2004 05:40:06 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org,
       geert@linux-m68k.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
References: <Pine.LNX.4.10.10411021743001.4822-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10411021743001.4822-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411030540.06262.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 02:03, Mark Fortescue wrote:
> Hi all,
>
> I have identified what is going on. My CG3 console uses the same font and
> exactly overlaps prom console. [I have re-inserted the console margin code
> for my CG3 driver]. The timing is such that the prom overwrites the
> console text (using colour 255) a fraction later than the fbcon code.
>
> The two problems to be solved are (apart from seting the red,green and
> blue structures up for the cg series fb cards):
>
> 1) The prom write (from -p) needs to be disabled as soon as an alternative
> console becomes active (either prom console, fbcon console or serial
> console). This has probably been the major cause of hassel.
>
> 2) The restore pallet function (see cgsix.c in the 2.2.x or 2.4.x kernels)
> needs to be re-introduced in some form and called when exiting fbcon so
> that the prom does not end up as black on black. My prom uses fg=255,

You can implement a cg3fb_open() and cg3fb_release() hooks and set up a
use_count field. You increment the count on every open, decrement on every
release. Then restore whatever on the last release. Optionally, you can even
do hardware inits on the first open.

Tony 


