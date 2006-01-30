Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWA3Pg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWA3Pg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWA3Pgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:36:55 -0500
Received: from mx03.qsc.de ([213.148.130.16]:13474 "EHLO mx03.qsc.de")
	by vger.kernel.org with ESMTP id S932335AbWA3Pgy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:36:54 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] Re: [PATCH] Adaptec USBXchange and USB2Xchange support
Date: Mon, 30 Jan 2006 16:36:15 +0100
User-Agent: KMail/1.9
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200509132253.53960.rene@exactcode.de> <200601301422.40500.rene@exactcode.de> <200601301622.19998.oliver@neukum.org>
In-Reply-To: <200601301622.19998.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601301636.15258.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Monday 30 January 2006 16:22, Oliver Neukum
	wrote: > Am Montag, 30. Januar 2006 14:22 schrieb  =?ISO-8859-1?Q?=20Ren=E9?= Rebe: > > + /*
	Stop CPU */ > > + err = usbxchange_set_reset(dev, cpureg, 1); > > + err
	= usbxchange_set_reset(dev, cpureg, 1); > > + if (err < 0) { > > +
	printk(KERN_ERR "%s - error stopping dongle CPU: error = %d\n", > > +
	__FUNCTION__, err); > > + return err; > > + } > > [..] > > > + /*
	De-assert reset (let the CPU run) */ > > + err =
	usbxchange_set_reset(dev, cpureg, 1); > > + err =
	usbxchange_set_reset(dev, cpureg, 0); > > + if (err < 0) { > > +
	printk(KERN_ERR "%s - error resetting dongle CPU: error = %d\n", > > +
	__FUNCTION__, err); > > + return err; > > + } > > Do you really want to
	ignore errors the first usbxchange_set_reset()s return? [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 30 January 2006 16:22, Oliver Neukum wrote:
> Am Montag, 30. Januar 2006 14:22 schrieb René Rebe:
> > +       /* Stop CPU */
> > +       err = usbxchange_set_reset(dev, cpureg, 1);
> > +       err = usbxchange_set_reset(dev, cpureg, 1);
> > +       if (err < 0) {
> > +               printk(KERN_ERR "%s - error stopping dongle CPU: error = %d\n",
> > +                      __FUNCTION__, err);
> > +               return err;
> > +       }
> 
> [..]
> 
> > +       /* De-assert reset (let the CPU run) */
> > +       err = usbxchange_set_reset(dev, cpureg, 1);
> > +       err = usbxchange_set_reset(dev, cpureg, 0);
> > +       if (err < 0) {
> > +               printk(KERN_ERR "%s - error resetting dongle CPU: error = %d\n",
> > +                      __FUNCTION__, err);
> > +               return err;
> > +       }
> 
> Do you really want to ignore errors the first usbxchange_set_reset()s return?

It is not really likely that the first one fails and the second succeeds. But yes,
I could add an if (err == 0) before the 2nd send and skip it when the first already
failed.

I can resent with more suggestions accumulated.

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
