Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269181AbTCBKmh>; Sun, 2 Mar 2003 05:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269182AbTCBKmh>; Sun, 2 Mar 2003 05:42:37 -0500
Received: from AMarseille-201-1-3-35.abo.wanadoo.fr ([193.253.250.35]:40231
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S269181AbTCBKmg>; Sun, 2 Mar 2003 05:42:36 -0500
Subject: Re: Multiple & vs. && and | vs. || bugs in 2.4 and 2.5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030302102751.GA26028@defiant>
References: <20030302102751.GA26028@defiant>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046602478.2030.105.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 02 Mar 2003 11:54:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 11:27, Norbert Kiesel wrote:

> linux-2.4.20/drivers/video/aty128fb.c:2534:		if (!reg & LVDS_ON) {
> linux-2.4.20/drivers/video/radeonfb.c:2781:		if (!lvds_gen_cntl & LVDS_ON) {

There two are single bit tests, they should probably be written
with an additional parenthesis:

	if (!(reg & LVDS_ON))
	if (!(lvds_gen_cntl & LVDS_ON))

Though in these specific cases, I tend to prefer writing it this way

	if ((reg & LVDS_ON) == 0)
	if ((lvds_gen_cntrl & LVDS_ON) == 0)

Since I'm the author of both of the above (though I'm not the driver
maintainer), feel free to send the typo fixes to Marcelo along with
Ani Joshi (driver maintainer)

Ben.
