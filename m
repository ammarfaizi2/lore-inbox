Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSHRKqO>; Sun, 18 Aug 2002 06:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSHRKqO>; Sun, 18 Aug 2002 06:46:14 -0400
Received: from go-gw.beelinegprs.com ([217.118.66.254]:12924 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S313898AbSHRKqN>; Sun, 18 Aug 2002 06:46:13 -0400
Date: Sun, 18 Aug 2002 14:49:48 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, dhinds <dhinds@sonic.net>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: New fix for CardBus bridge behind a PCI bridge
Message-ID: <20020818144948.A1241@localhost.park.msu.ru>
References: <20020812110431.A14125@sonic.net> <20020812112911.A18947@lucon.org> <20020812122158.A27172@sonic.net> <20020812140730.A21710@lucon.org> <20020812154851.A20073@sonic.net> <20020812202942.A27362@lucon.org> <20020816194825.A7086@jurassic.park.msu.ru> <20020816224950.A17930@lucon.org> <3D5E6B10.9070106@mandrakesoft.com> <20020817083601.A26274@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020817083601.A26274@lucon.org>; from hjl@lucon.org on Sat, Aug 17, 2002 at 08:36:01AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 08:36:01AM -0700, H. J. Lu wrote:
> It could be. But I doubt it. At least, I don't think you can treat a
> AGP bridge like a 82801BAM/CAM bridge. I think 82801BAM/CAM is a
> special case. You really have to read the datasheet to know for sure.

You're right by all means. AGP bridges are _always_ positive decoders.
The problems you've seen were caused by the wrong semicolon somehow
sneaked into the patch:

+static void __init pci_fixup_transparent_bridge(struct pci_dev *dev)
+{
+	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
+	    (dev->device & 0xff00) == 0x2400);
					     ^ Ugh..
+		dev->class |= 1;
+}

Which means that I'm setting bit 0 in the ProgIf for _all_ Intel devices...
I'm really sorry about that.
Thanks for the pci dump - it's very useful anyway.

Ivan.
