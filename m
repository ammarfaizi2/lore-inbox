Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbUKPX3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUKPX3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUKPX1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:27:48 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:33299 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261886AbUKPX0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:26:04 -0500
Date: Wed, 17 Nov 2004 00:26:00 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm <akpm@osdl.org>, ak@suse.de, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [PATCH] PCI: fix build errors with CONFIG_PCI=n
Message-ID: <20041116232600.GB2868@pclin040.win.tue.nl>
References: <419A8088.3010205@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419A8088.3010205@osdl.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 02:34:48PM -0800, Randy.Dunlap wrote:

> Fix (most of) kernel build for CONFIG_PCI=n.  Fixes these 3 errors:
> 
> 1. drivers/parport/parport_pc.c:3162: error: `parport_init_mode'
> undeclared (first use in this function)

Life is easier if you do not use attachments.
(Then I can more easily comment the code.)

You write

  -static int __init parport_init_mode_setup(const char *str) {
  -
  +#ifdef CONFIG_PCI
  +static int __init parport_init_mode_setup(const char *str)

In my tree I have

  static int __init parport_init_mode_setup(char *str) {

in order to avoid the warning for

  __setup("parport_init_mode=",parport_init_mode_setup);

since the parameter is a int (*setup_func)(char *); - see

  struct obs_kernel_param {
        const char *str;
        int (*setup_func)(char *);
        int early;
  };

Apart from this prototype change I only moved the single line

  static int __initdata parport_init_mode = 0;

outside the #ifdef's. Is that not good enough, and better
than introducing more #ifdef's? Keeps the source smaller.

Andries
