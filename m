Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130748AbQLNTPK>; Thu, 14 Dec 2000 14:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131738AbQLNTPB>; Thu, 14 Dec 2000 14:15:01 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:55815 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130748AbQLNTOz>; Thu, 14 Dec 2000 14:14:55 -0500
Date: Thu, 14 Dec 2000 19:42:21 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Nicolas Pitre <nico@cam.org>, morton@nortelnetworks.com,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: [Fwd: [PATCH] cs89x0 is not only an ISA card]
Message-ID: <20001214194221.K15157@arthur.ubicom.tudelft.nl>
In-Reply-To: <200012141525.PAA00867@raistlin.arm.linux.org.uk> <3A38FC9D.7B2F2B7D@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A38FC9D.7B2F2B7D@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Dec 14, 2000 at 12:00:13PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 12:00:13PM -0500, Jeff Garzik wrote:
> Russell King wrote:
> > Maybe the right thing to do is to define CONFIG_ISA on these architectures/
> > machine types where the device itself is actually an ISA device, instead of
> > going through special-casing the driver configuration entries?
> 
> Agreed.  We -don't- want to remove CONFIG_ISA or other dependencies. 
> The idea for drivers/net/Config.in at least is that all architectures
> can source the file, and be presented with a proper list of devices for
> that platform.
> 
> For an embedded board that supports cs89x0, as you suggest, defining
> CONFIG_ISA is a much better option.  Or, making cs89x0 dependent on
> CONFIG_EMBEDDED_PLATFORM -and- CONFIG_ISA.

No, the cs89x0 can be used on systems that don't have an ISA bus at
all. It just needs 16 data lines, a couple of address lines and some
selection lines, but that's all. It's very nice for embedded designs
because it's a single chip solution. Add a 20MHz crystal, a
transformer, and a connector and you're set.

OK, what about this patch. As far as I know, the cs89x0 is only used on
Intel SA11x0 and Cirrus PS7500FE platforms in the ARM world (Russell,
please correct me if I'm wrong). This patch make it dependent on
CONFIG_ISA, CONFIG_ARCH_SA1100, or CONFIG_ARCH_CLPS7500.


Erik

PS: Your CVS hints work, Jeff :-)

Index: drivers/net/Config.in
===================================================================
RCS file: /home/erik/cvsroot/elinux/drivers/net/Config.in,v
retrieving revision 1.1.1.39
diff -u -r1.1.1.39 Config.in
--- drivers/net/Config.in	2000/12/07 14:16:21	1.1.1.39
+++ drivers/net/Config.in	2000/12/14 18:34:01
@@ -134,7 +138,9 @@
       fi
 
       tristate '    Apricot Xen-II on board Ethernet' CONFIG_APRICOT
-      dep_tristate '    CS89x0 support' CONFIG_CS89x0 $CONFIG_ISA
+      if [ "$CONFIG_ISA" = "y" -o "$CONFIG_ARCH_SA1100" = "y" -o "$CONFIG_ARCH_CLPS7500" = "y" ] ; then
+         tristate '    CS89x0 support' CONFIG_CS89x0
+      fi
       dep_tristate '    DECchip Tulip (dc21x4x) PCI support' CONFIG_TULIP $CONFIG_PCI
       if [ "$CONFIG_PCI" = "y" -o "$CONFIG_EISA" = "y" ]; then
          tristate '    Generic DECchip & DIGITAL EtherWORKS PCI/EISA' CONFIG_DE4X5


-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
