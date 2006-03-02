Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWCBQDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWCBQDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbWCBQDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:03:44 -0500
Received: from mx03.qsc.de ([213.148.130.16]:61413 "EHLO mx03.qsc.de")
	by vger.kernel.org with ESMTP id S1751983AbWCBQDn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:03:43 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Greg KH <greg@kroah.com>
Subject: Re: MAX_USBFS_BUFFER_SIZE
Date: Thu, 2 Mar 2006 17:03:26 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.org>
References: <200603012116.25869.rene@exactcode.de> <200603012242.35633.rene@exactcode.de> <20060301215423.GA17825@kroah.com>
In-Reply-To: <20060301215423.GA17825@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603021703.26549.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Wednesday 01 March 2006 22:54, Greg KH wrote: > >
	> Why not just send down 2 urbs with that size then, that would keep the
	> > > pipe quite full. > > > > Because that requires even more
	modifications to libusb and sane (i_usb) ... > > No, do it in your
	application I mean. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 01 March 2006 22:54, Greg KH wrote:

> > > Why not just send down 2 urbs with that size then, that would keep the
> > > pipe quite full.
> > 
> > Because that requires even more modifications to libusb and sane (i_usb) ...
> 
> No, do it in your application I mean.

Ok, tweaking libusb to queue N URBs for reads to be split (resulting in 9 URBs
in my usecase) I see a nearly 100% improvement here (2 times faster).

How many URBs may I queue? Nearly infinite (in my case that would be max 64)
or is there some tiny static list somewhere in the affected code-path?

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
