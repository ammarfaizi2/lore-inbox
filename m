Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTDQOWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbTDQOWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:22:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39878
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261528AbTDQOWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:22:09 -0400
Subject: RE: Subtle semantic issue with sleep callbacks in drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304161133110.912-100000@cherise>
References: <Pine.LNX.4.44.0304161133110.912-100000@cherise>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050586549.31414.41.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 14:35:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 19:39, Patrick Mochel wrote:
> I completely agree with Andy. We should not re-POST the video hardware, no
> matter what. The idea behind ACPI is that the OS takes care of everything, 
> including video save/restore. 

Outside of happyville ivory towers you probably have no choice. Only the
BIOS knows stuff like the RAM timings, and some windows drivers just use
the BIOS, others rely on being shipped compiled for the right variant of
card they came with.

We keep the BIOS segment data so you can re-post the card on the 16bit
resume path. Probably there should be a flag for relevant frame buffer
drivers to set that says "don't re-Post but call me later"

> We may not have the documentation to properly do that for all hardware 
> currently, but that is something that we have to suck up and deal with. 

> For now, we go with hardware that we're able to handle. 

Thats pretty close to "there isnt any"

> The drivers that cannot support reinitialization will not be able to 
> support suspend-to-RAM. When we get to a point where it really becomes an 
> issue (i.e. after we have decent working code), then we concentrate on 
> getting the appropriate docuementation (or code itself, source or binary) 
> to do it correctly. 

X people have been trying to do this for multihead setups for years.
You'll get Matrox, you'll get 3DFX voodoo1/2, you might get early SiS.
Intel - dunno, but the rest - no chance.

> Trying to figure out if we need to POST or not for different hardware, 
> based what the driver knows, is going to become quite a mess real fast. I 
> don't want to deal with the pain, and would rather take the high ground, 
> even if it means suffering in the short term. 

Short, long and forever. I agree we want drivers to be able to say "Don't POST
I can hack this one", however we need to accept the real world that most
hardware wants posting and that in many cases its what the windows driver
does anyway.


