Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264779AbUDWKqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264779AbUDWKqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 06:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUDWKqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 06:46:09 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:50880 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S264779AbUDWKqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 06:46:05 -0400
Date: Fri, 23 Apr 2004 12:46:00 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Peter Osterlund <petero2@telia.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFT] ALPS touchpad driver
In-Reply-To: <200404230230.38548.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.40.0404231236500.2850-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Apr 2004, Dmitry Torokhov wrote:

> I found on the net a possible way to detect ALPS driver so I made some changes
> to your driver. Unfortunately I do not have ALPS touchpad so if anyone could
> give it a spin I's appreciate it.


> +	/* Now try "E7 report". ALPS should return 0x33 in byte 1 */
> +	param[0] = 0;
> +	if (psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES) ||
> +	    psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE21) ||
> +	    psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE21) ||
> +	    psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE21))
> +		return 0;
> +
> +	param[0] = param[1] = param[2] = 0xff;
> +	if (psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO))
> +		return 0;
> +
> +	printk(KERN_INFO "alps.c: E7 report: %2.2x %2.2x %2.2x\n",
> +		param[0], param[1], param[2]);
> +
> +	return param[0] != 0x33;


Depending on ALPS version this request is also known to return one of
glidepats:
0x33,0x02,0x0a,
0x53,0x02,0x0a,
0x53,0x02,0x14,
0x63,0x02,0x0a,
0x63,0x02,0x14,
0x63,0x02,0x28,
0x63,0x02,0x3c,
0x63,0x02,0x50,
0x63,0x02,0x64,
0x73,0x02,0x0a,

glidepoints:
0x20,0x02,0x0e,
0x22,0x02,0x0a,
0x22,0x02,0x14,

Peter
--
E-Mail:       pebl@math.ku.dk
Real name:    Peter Berg Larsen
Where:        Department of Computer Science, Copenhagen Uni., Denmark


