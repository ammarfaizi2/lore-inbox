Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTLYJPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 04:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbTLYJPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 04:15:23 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:50335 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264147AbTLYJPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 04:15:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>
Subject: Re: 2.6.0-mm1
Date: Thu, 25 Dec 2003 04:11:54 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
References: <20031224095921.GA8147@lsc.hu> <20031224033200.0763f2a2.akpm@osdl.org>
In-Reply-To: <20031224033200.0763f2a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312250411.55881.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 December 2003 06:32 am, Andrew Morton wrote:
> GCS <gcs@lsc.hu> wrote:
[..SKIP..]
>
> > - I have a synaptics touchpad, which is detected correctly, but only
> >   works if I set psmouse_noext=1. Under vanilla 2.6.0 it still works
> > this way, but with 2.6.0-mm1 it works only on the console, but not
> > under XFree86. Strange, as gpm interprets the input and pipes thru
> > gpmdata to XFree86 4.3.0. Any idea what broke this configuration?
>
> Peter or Dmitry may be able to tell us.

Whew.. that wasn't easy to spot... When doing PS/2 emulation for touchpads
that use absolute events, when processing BTN_TOUCH event mousedev would
stop on the very first client. So in your normal case only GPM would see
the Synaptics but once you killed GPM XFree would be the first in line and
magically start working.

My guess you didn't see that in stock 2.6.0 because you were compiling
without Synaptics support.

I am sending 2 patches - one to remove mouse jitter with Synaptics when
it is used through mousedev (PS/2 emulation) - mousedev will use 3 point
history and average when calculating deltas, the other one is the fix for
the problem you are experiencing. They should apply to 2.6.0-mm1 and to
stock 2.6.0 with minimal jitter.

Dmitry
