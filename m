Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTLJRyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTLJRyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:54:47 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:36508
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S263834AbTLJRyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:54:46 -0500
From: Duncan Sands <baldrick@free.fr>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Wed, 10 Dec 2003 18:54:44 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312101749.17173.baldrick@free.fr> <3FD7591A.8020100@pacbell.net>
In-Reply-To: <3FD7591A.8020100@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101854.44636.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 18:34, David Brownell wrote:
> > Unfortunately, usb_physical_reset_device calls usb_set_configuration
> > which takes dev->serialize.
>
> Not since late August it doesn't ...

In current 2.5 bitkeeper it does.

Duncan.

int usb_set_configuration(struct usb_device *dev, int configuration)
{
        int i, ret;
        struct usb_host_config *cp = NULL;

        /* dev->serialize guards all config changes */
        down(&dev->serialize);
