Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTIYXin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTIYXin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:38:43 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:44292 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262040AbTIYXim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:38:42 -0400
Date: Fri, 26 Sep 2003 01:38:37 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: akpm@osdl.org, dtor_core@ameritech.net, petero2@telia.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Extend KD?BENT to handle > 256 keycodes.
Message-ID: <20030925233837.GA21764@win.tue.nl>
References: <10645086121089@twilight.ucw.cz> <1064508612197@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064508612197@twilight.ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 06:50:12PM +0200, Vojtech Pavlik wrote:

> -struct kbentry {
> +struct kbentry_old {
>  	unsigned char kb_table;
>  	unsigned char kb_index;
>  	unsigned short kb_value;
>  };
> +#define KDGKBENT_OLD	0x4B46	/* gets one entry in translation table (old) */
> +#define KDSKBENT_OLD	0x4B47	/* sets one entry in translation table (old) */
> +
> +struct kbentry {
> +	unsigned int kb_table;
> +	unsigned int kb_index;
> +	unsigned short kb_value;
> +};

> -#define KDGKBENT	0x4B46	/* gets one entry in translation table */
> -#define KDSKBENT	0x4B47	/* sets one entry in translation table */
> +#define KDGKBENT	0x4B73	/* gets one entry in translation table */
> +#define KDSKBENT	0x4B74	/* sets one entry in translation table */

Please don't.

As said already, no new ioctls are needed today, but if you add some
anyway, please leave old names unchanged and add something new, like
KDSKBENT32 or so.

Reusing old ioctl names for new uses is very bad practice.

Andries

