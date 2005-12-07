Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVLGQ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVLGQ6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVLGQ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:58:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43659 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751208AbVLGQ6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:58:20 -0500
Date: Wed, 7 Dec 2005 11:58:11 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Missing break in timedia serial setup.
Message-ID: <20051207165811.GA3574@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20051207010526.GA7258@redhat.com> <20051207093431.GB32365@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207093431.GB32365@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 09:34:31AM +0000, Russell King wrote:
 > On Tue, Dec 06, 2005 at 08:05:26PM -0500, Dave Jones wrote:
 > > Spotted during code review by a Fedora user.
 > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=174967
 > 
 > Makes no difference.
 > 
 >         switch (idx) {
 >         case 3:
 >                 bar = 1;
 >         case 4: /* BAR 2 */
 >         case 5: /* BAR 3 */
 >         case 6: /* BAR 4 */
 >         case 7: /* BAR 5 */
 >                 bar = idx - 2;
 > 
 > If idx is 3, idx - 2 is 1.  So the bar = 1 is actually redundant in
 > case 3.

Duh, yes of course. Here's a patch to remove the redundant assignment,
but as it's harmless, I'll leave it up to you to decide whether or
not it's worth applying.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/serial/8250_pci.c~	2005-12-07 11:56:13.000000000 -0500
+++ linux-2.6.14/drivers/serial/8250_pci.c	2005-12-07 11:56:41.000000000 -0500
@@ -516,7 +516,6 @@ pci_timedia_setup(struct serial_private 
 		break;
 	case 3:
 		offset = board->uart_offset;
-		bar = 1;
 	case 4: /* BAR 2 */
 	case 5: /* BAR 3 */
 	case 6: /* BAR 4 */
