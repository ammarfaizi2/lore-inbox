Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVAGR2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVAGR2w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVAGR2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:28:51 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:8719 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261356AbVAGR2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:28:44 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALPS touchpad detection fix
Date: Fri, 7 Jan 2005 19:28:32 +0200
User-Agent: KMail/1.5.4
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
References: <m3wtuqxzue.fsf@telia.com>
In-Reply-To: <m3wtuqxzue.fsf@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501071928.32096.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 January 2005 18:54, Peter Osterlund wrote:
> My ALPS touchpad is not recognized because the device gets confused by
> the Kensington ThinkingMouse probe.  It responds with "00 00 14"
> instead of the expected "00 00 64" to the "E6 report".
> 
> Resetting the device before attempting the ALPS probe fixes the
> problem.
> 
> Signed-off-by: Peter Osterlund <petero2@telia.com>
> ---
> 
>  linux-petero/drivers/input/mouse/psmouse-base.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -puN drivers/input/mouse/psmouse-base.c~alps-fix drivers/input/mouse/psmouse-base.c
> --- linux/drivers/input/mouse/psmouse-base.c~alps-fix	2005-01-06 17:33:15.000000000 +0100
> +++ linux-petero/drivers/input/mouse/psmouse-base.c	2005-01-06 17:33:46.000000000 +0100
> @@ -451,6 +451,7 @@ static int psmouse_extensions(struct psm
>  /*
>   * Try ALPS TouchPad
>   */
> +	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
>  	if (max_proto > PSMOUSE_IMEX && alps_detect(psmouse, set_properties) == 0) {
>  		if (!set_properties || alps_init(psmouse) == 0)
>  			return PSMOUSE_ALPS;

You do reset even if max_proto <= PSMOUSE_IMEX and therefore
alps_detect won't be called. Is it intended?
--
vda

