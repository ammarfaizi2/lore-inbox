Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSKNShj>; Thu, 14 Nov 2002 13:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSKNShj>; Thu, 14 Nov 2002 13:37:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39429 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261545AbSKNShi>;
	Thu, 14 Nov 2002 13:37:38 -0500
Date: Thu, 14 Nov 2002 18:44:31 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] eliminate pci_dev name
Message-ID: <20021114184431.E30392@parcelfarce.linux.theplanet.co.uk>
References: <3DD3EB3D.8050606@pobox.com> <Pine.LNX.4.44.0211141031500.3323-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211141031500.3323-100000@home.transmeta.com>; from torvalds@transmeta.com on Thu, Nov 14, 2002 at 10:36:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 10:36:03AM -0800, Linus Torvalds wrote:
> Actually, I think we should do the reverse (for testing), and make the
> name be something small like 8 bytes, and make sure that everybody who
> writes the name uses strncpy()  and snprintf() instead of just blindly
> writing whatever is in the database.
> 
> Otherwise we'll always end up having fragile magic constants.
> 
> Anybody willing to do that cleanup?

Sure, I can do that.  That leads me to think that maybe we should
delete name from struct device and just use the one in struct kobject
(which is already a mere 16 bytes).  But if we're going to go as far
down as the kobject... that has a dentry.  And dentrys have names.
So how about eliminating that too and just creating a dentry with the
almost infinitely long name?

Maybe that's too much at this stage of the game.

-- 
Revolutions do not require corporate support.
