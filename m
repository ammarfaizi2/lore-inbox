Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbTFYSja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTFYSja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:39:30 -0400
Received: from blanch.math.uwaterloo.ca ([129.97.204.29]:411 "EHLO
	blanch.math.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S265001AbTFYSj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:39:28 -0400
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: davids@webmaster.com
Subject: RE: GPL violations by wireless manufacturers
Date: Wed, 25 Jun 2003 14:53:21 -0400
User-Agent: KMail/1.5
Cc: vanstadentenbrink@ahcfaust.nl, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306251453.21684.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

David Schwartz wrote:
>  Perhaps it's not a separate work from the programs that access it, but it's
>  certainly a separate work from the kernel. The kernel can operate just fine
>  without the module. The module extends the kernel through a well-defined
>  boundary.

I'm not sure this is entirely accurate.  A quick look at the module in 
question (wl.o) with "nm" reveals quite a few interesting imports and 
exports.

The module, for example, makes approximately 50 imports from the kernel where 
the import doesn't seem to be part of the regular kernel tree (ie. I searched 
using http://lxr.linux.no to no avail).  However, these symbols seem to be  
defined in the kernel included with the device.  That is to say, the symbols 
aren't provided by another module.  Therefore, it would appear that this 
module will not work with a "stock" Linux kernel.

These symbols (they all appear to be routines) begin with the following 
prefixes: bcm, dma, osl, pkt, sb.

The purpose of some of these routines can be determined by the function name.  
For example, the 'sb' series of functions seem to be used for manipulating 
the Sonics SiliconBackplane that is used by the BCM43xx.  The DMA routines 
might be used to handle the TX and RX ring buffers.  Some of the others I am 
not so sure about.  (By the way, this was also discovered by Lex Winter, 
whose post to LKML seems to show up in groups.google, but not in the other 
archives.)

Additionally, the module exports (ie. shows up with 'T' in an nm listing) no 
less than 117 symbols.  Some of these appear pretty low-level: 

read_radio_reg
wlc_set_11a_txpower
wlc_set_11b_radiopwr
wlc_set_channel
wlc_aphy_temp_sense
write_radio_reg

to name just a few.


Admittingly, I don't know very much about what constitutes the standard kernel 
to wireless driver interface for Linux.  Also, I don't know if all these 
exported functions are actually called externally.  However, after looking 
through some other wireless driver modules (airo, hermes, orinoco) I can't 
seem to find an example where a module exports nearly as many functions.

If anyone would like a copy of the symbol list for wl.o (it requires a MIPS 
binutils), please drop me an e-mail, and I'd be happy to send it out.  
Additionally, if I've made any mistakes in these conclusions, please also let 
me know.



-- Andrew
