Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTLJQtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 11:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTLJQtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 11:49:20 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:6300
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S263740AbTLJQtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 11:49:19 -0500
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Wed, 10 Dec 2003 17:49:17 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312101422.40088.baldrick@free.fr> <200312101720.22731.oliver@neukum.org>
In-Reply-To: <200312101720.22731.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101749.17173.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 17:20, Oliver Neukum wrote:
> Am Mittwoch, 10. Dezember 2003 14:22 schrieb Duncan Sands:
> > > That leads to the question of how to assure that the device doesn't go
> > > away before usb_set_configuration is called.  Perhaps
> > > usb_set_configuration and usb_unbind_interface should be changed to
> > > require the caller to hold the serialize lock.
> >
> > How about
> >
> > __usb_set_configuration - lockless version
> > usb_set_configuration - locked version
>
> Partially done.
> That's what the _physical version of usb_reset_device() is about.

Unfortunately, usb_physical_reset_device calls usb_set_configuration
which takes dev->serialize.

Duncan.
