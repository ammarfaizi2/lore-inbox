Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264020AbUDNNiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbUDNNiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:38:24 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:27017 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264020AbUDNNiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:38:22 -0400
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Wed, 14 Apr 2004 15:38:19 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141245.37101.baldrick@free.fr> <200404141530.54093.oliver@neukum.org>
In-Reply-To: <200404141530.54093.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141538.19189.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 15:30, Oliver Neukum wrote:
> Am Mittwoch, 14. April 2004 12:45 schrieb Duncan Sands:
> > The remaining three patches contain miscellaneous fixes to usbfs.
> > This one fixes up the disconnect callback to only shoot down urbs
> > on the disconnected interface, and not on all interfaces.  It also adds
> > a sanity check (this check is pointless because the interface could
> > never have been claimed in the first place if it failed, but I feel
> > better having it there).
>
> Well, I don't. If you care about it, add a WARN_ON().
> Checking without consequences is bad.

If the check fails then you are scribbling over kernel memory.  So the
consequences of the check failing are bad.  Also, it is in a slow path.
Thus I prefer to have the check even if it is supposed to never fail.  I
agree that a message should also be output.

Duncan.
