Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWFTRgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWFTRgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWFTRgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:36:11 -0400
Received: from xenotime.net ([66.160.160.81]:12446 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750702AbWFTRgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:36:10 -0400
Date: Tue, 20 Jun 2006 10:38:57 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based Macs
Message-Id: <20060620103857.632a0747.rdunlap@xenotime.net>
In-Reply-To: <4497FA12.8090708@ed-soft.at>
References: <4497FA12.8090708@ed-soft.at>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 15:37:22 +0200 Edgar Hucek wrote:

> This patch add a new framebuffer driver for the Intel Based macs.
> This framebuffer is needed when booting from EFI to get something
> out the box ;)


To the extent possible, please list #include files in
alpha order within each group of <linux>, <asm>, etc.


+typedef enum _MAC_TAPE {
+	M_I17,
+	M_I20,
+	M_MINI,
+	M_MACBOOK,
+	M_NEW
+} MAC_TAPE;

What is TAPE?  should this be TYPE?

Use hard tabs on this line:
+      	.activate	= FB_ACTIVATE_NOW,


+static int             inverse   = 0;
+static int             mtrr      = 0; /* disable mtrr */
+static int	       vram_remap __initdata = 0; /* Set amount of memory to be used */
+static int	       vram_total __initdata = 0; /* Set total amount of memory */
+static int             depth;
+static int             model = M_NEW;
+static int             manual_height = 0;
+static int             manual_width = 0;

Misaligned.  Using hard tabs would help.

+		if (! strcmp(this_opt, "inverse"))
+			inverse=1;

No space between ! and strcmp (multiple places).
Do put spaces around '=' sign.

+#define dac_reg	(0x3c8)
+#define dac_val	(0x3c9)

Are these used?  And the parens are superfluous.
However, if you want to use parens, then using them here would
make more sense:
+#define	DEFAULT_FB_MEM	1024*1024*16

+	if(manual_height > 0)
+		screen_info.lfb_height = manual_height;
+	if(manual_width > 0)
+		screen_info.lfb_width = manual_width;

Space after 'if'.

+	printk(KERN_INFO "imacfb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
+	       imacfb_defined.xres, imacfb_defined.yres, imacfb_defined.bits_per_pixel, imacfb_fix.line_length, screen_info.pages);

Break long source lines at < 80 columns, please.

+	if (imacfb_defined.bits_per_pixel <= 8) {
+		depth = imacfb_defined.green.length;
+		imacfb_defined.red.length =
+		imacfb_defined.green.length =
+		imacfb_defined.blue.length =
+		imacfb_defined.bits_per_pixel;
+	}

Maybe that last line should be indented one more tab stop.
Anyway, they shouldn't all be at the same indentation.


---
~Randy
