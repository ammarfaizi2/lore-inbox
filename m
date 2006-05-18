Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWERQRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWERQRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 12:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWERQRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 12:17:43 -0400
Received: from plausible.org ([66.93.174.199]:64923 "EHLO plausible.org")
	by vger.kernel.org with ESMTP id S1751371AbWERQRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 12:17:42 -0400
Message-ID: <446C9E25.9050906@plausible.org>
Date: Thu, 18 May 2006 09:17:41 -0700
From: Andy Ross <andy@plausible.org>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
CC: openezx-devel@lists.gnumonks.org, linux-kernel@vger.kernel.org
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org>
In-Reply-To: <20060518070700.GT17897@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
> 0) What kind of X/Y/Pressure values should I return?  Are they supposed
>    to be scaled to the X/Y resolution of the LCD?  As of now, I return
>    X_ABS, Y_ABS and PRESSURE values between 0 and 1000 (each).
>
>    However, the coordinates are actually inverted, so '0,0' corresponds
>    to the lower right corner of the screen, whereas '1000,1000' is the
>    upper left corner.  Shall I invert them (i.e. return 1000-coord')?

The native driver reports pressure as either 65535 or 0, and doesn't
(seem to) scale the x/y values at all.  The uncalibrated values and
180 degree rotation (actually, my phone shows a slight rotation error
or a few pixels) are definitely reported to user space without
modification.

A matrix-based recalibrator will handle any orientation so long as the
corners are known, and so long as you report a pressure of zero
meaning "pen up" everything should be compatible regardless of the
units you choose.

Andy
