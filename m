Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTF2UUk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTF2UUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:20:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31749 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262499AbTF2UUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:20:34 -0400
Date: Sun, 29 Jun 2003 21:34:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@redhat.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: Re: [PATCH] Fix mtdblock / mtdpart / mtdconcat
Message-ID: <20030629213450.B5653@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@redhat.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mtd@lists.infradead.org
References: <20030623010031.E16537@flint.arm.linux.org.uk> <1056544988.24294.9.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1056544988.24294.9.camel@passion.cambridge.redhat.com>; from dwmw2@redhat.com on Wed, Jun 25, 2003 at 01:43:09PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 01:43:09PM +0100, David Woodhouse wrote:
> On Mon, 2003-06-23 at 01:00, Russell King wrote:
> > Dirtily disable ECC support; it doesn't work when mtdpart is layered
> > on top of mtdconcat on top of CFI flash.
> > 
> > There is probably a better fix, but that's for someone else to find.
> 
> I had to run 'indent' on mtdconcat.c before I could stand to even look
> for it, so I haven't attached the patch here -- but could you try v1.6
> from CVS, which should refrain from pretending to have ecc/oob access
> functions of none of the subdevices have them, and hence fix the problem
> you observed.

While looking over the changes between 1.5 and 1.6, I spotted this.  You
may want to fix this change:

-                   concat->mtd.eccsize != subdev[i]->eccsize) {
+                   concat->mtd.eccsize != subdev[i]->eccsize ||
+                   !concat->mtd.read_ecc != !concat->mtd.read_ecc ||
+                   !concat->mtd.write_ecc != !concat->mtd.write_ecc ||
+                   !concat->mtd.read_oob != !concat->mtd.read_oob ||
+                   !concat->mtd.write_oob != !concat->mtd.write_oob) {

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

