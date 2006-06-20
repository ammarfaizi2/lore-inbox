Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWFTOGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWFTOGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWFTOGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:06:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9143 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750975AbWFTOGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:06:44 -0400
Subject: Re: update pci device id
From: Arjan van de Ven <arjan@infradead.org>
To: cckuo <chechun_kuo@sis.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF39A58CF4.C4A06C9A-ON48257193.004A1ACB@sis.com.tw>
References: <OF39A58CF4.C4A06C9A-ON48257193.004A1ACB@sis.com.tw>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 16:06:42 +0200
Message-Id: <1150812402.2891.202.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 21:28 +0800, cckuo wrote:
> Dear All:
> Recently my company, sis, releases some new platforms for intel socket 775,
> and AMD socket 939. I have read the MAINTAINERS and cannot find someone whom
> I can let him help me to add the pci device id. 
> If someone knows who takes charge of this part, please let me know.

Hi,

the answer is a bit complex; I'll try to break it down in steps ...

step 1) the text database as used by lspci
This is quite easy, just go to http://pciids.sourceforge.net/ and add
your pci ids to the database

step 2) the drivers
this is a bit more work, basically this is about teaching individual
drivers that support your hardware about your new IDs.

for example the i810-like audio driver has a table like this:

 static struct pci_device_id snd_intel8x0_ids[] __devinitdata = {
        { 0x8086, 0x2415, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL }, /* 82801AA */
        { 0x8086, 0x2425, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL }, /* 82901AB */
        { 0x8086, 0x2445, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL }, /* 82801BA */
        { 0x8086, 0x2485, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL }, /* ICH3 */


if your hw is compatible, just add your ID, test the new river (since
you have the hardware) and send a patch to the driver mainter and/or the
lkml mailing list

Does this answer your question?

Greetings,
   Arjan van de Ven

