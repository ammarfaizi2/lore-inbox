Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVB1FLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVB1FLY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 00:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVB1FLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 00:11:24 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:48590 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261558AbVB1FLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 00:11:21 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Olaf Hering <olh@suse.de>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.11-rc5
Date: Sat, 26 Feb 2005 15:41:47 +0800
User-Agent: KMail/1.5.4
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050226004137.GA25539@suse.de> <1109380389.15026.112.camel@gaston>
In-Reply-To: <1109380389.15026.112.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502261541.49187.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 February 2005 09:13, Benjamin Herrenschmidt wrote:
> On Sat, 2005-02-26 at 01:41 +0100, Olaf Hering wrote:
> > modedb can not be __init because fb_find_mode() may get db == NULL.
> > fb_find_mode() is called from modules.
>
> Ahhh, good catch ! I though that was fixed long ago, looks like I was
> wrong.

The 2.4 fix was for fb_find_mode to always return 640x480 if modular.
There's no fix yet for 2.6 except for the patch which is already in the mm
tree, which is for fb_find_mode() to always fail if driver is compiled as a
module. (patch below).

Both fixes will still crash if fb_find_mode() is called again, so this
function is really designed to be called only once.

As for the other patch that removes the __init from modedb, some of the
developers might disagree. 

Olaf,

Can you send me your EDID block?  You can use read-edid.  Your monitor
may have a fixable EDID and can be a candidate for the broken display
database.

Tony


