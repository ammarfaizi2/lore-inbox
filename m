Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314498AbSDXEIi>; Wed, 24 Apr 2002 00:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314511AbSDXEIh>; Wed, 24 Apr 2002 00:08:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49131 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314498AbSDXEIg>;
	Wed, 24 Apr 2002 00:08:36 -0400
Date: Tue, 23 Apr 2002 20:59:13 -0700 (PDT)
Message-Id: <20020423.205913.43844153.davem@redhat.com>
To: EdV@macrolink.com
Cc: peterson@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: PowerPC Linux and PCI
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A77B0@EXCHANGE>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ed Vance <EdV@macrolink.com>
   Date: Tue, 23 Apr 2002 10:16:16 -0700

   James L Peterson wrote: 
   > What does this mean?  This suggests that PCI controller for
   > big-endian systems are not interchangeable with PCI controllers
   > for little-endian systems, because the controller itself does
   > byte swapping (is that what you mean by "byte twisting"?)
   
   I think David's reference is to the system's PCI subsystem/interface rather
   than to the PCI cards plugged into it.

No, I'm talking about the "PCI host controller" the thing that
connects the PCI bus to the system bus :-)

And to address James's concern, yes unmodified such a PCI controller
won't work on a little-endian system, but any sane hardware designed
would add at least a jumper of some sort to switch the behavior of
the endianness features.

All of this has to do with what "byte X" within a word means when it
comes from a little endian vs. a big endian processor.

Can I ask you to have a stare at the following document before
continuing this thread further?

	http://www.sun.com/processors/manuals/802-7835.pdf

In particular, I wish you would read Chapter 10 "endianness support".
it starts on page 115.  Sun's controller does things right, compare it
with yours to see if it deals with the byte lanes correctly when
hooked up to a big endian processor :-)

Note your original problem is an absolutely trite example, if that
code in the kernel doesn't work you are going to have tons of other
problems elsewhere when accessing things on the PCI bus.
