Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTGFRcl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266253AbTGFRcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:32:41 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:55002 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263025AbTGFRck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:32:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: James Morris <jmorris@intercode.com.au>
Subject: Re: crypto API and IBM z990 hardware support
Date: Sun, 6 Jul 2003 19:46:41 +0200
User-Agent: KMail/1.5.1
Cc: Thomas Spatzier <TSPAT@de.ibm.com>, <linux-kernel@vger.kernel.org>
References: <Mutt.LNX.4.44.0307062353420.548-100000@excalibur.intercode.com.au>
In-Reply-To: <Mutt.LNX.4.44.0307062353420.548-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307061946.41991.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 July 2003 16:08, James Morris wrote:

> While this looks like it will work fine for the z990, it is a special case
> which does not address other requirements for hardware support (some
> initial requirements are listed at
> http://www.intercode.com.au/jamesm/crypto/hardware_notes.txt).
>
> I'm not enthusiastic about adding infrastructure which is really just a
> hack for some quaint hardware, and probably does not work towards
> addressing more common hardware requirements.

Ok, then I guess the module will simply have to declare MODULE_ALIAS("aes")
and live in arch/s390/crypto/, which means that the common code
is not touched at all, but building both the z990 assembler as well
as the C implementation as modules requires editing /etc/modprobe.conf
to get the right one.

As soon as you have the new API for crypto cards, we can move to that
for autoprobing the CPU features and reliably using the right 
implementation.

Maybe you can add to your list something like the following items:

Requirements:
- Support for CPU specific optimized algorithms:
  - autodetection of CPU features (e.g. Pentium MMX or z990 crypto)
  - selection of different implementations. A high priority job
    probably wants to use the CPU while another job offloads crypto
    to an asynchronous add-on card.

Hardware Documentation status:
- IBM zSeries cryptographic instructions:
  http://publibfp.boulder.ibm.com/cgi-bin/bookmgr/BOOKS/dz9zr002/7.5.25

GPL Driver status:
- IBM PCICC and PCICA cards (incompatible API):
  Robert Burroughs <burrough@us.ibm.com>
  http://oss.software.ibm.com/developerworks/opensource/linux390/june2003_recommended.shtml	
- IBM zSeries cryptographic instructions:
  Thomas Spatzier (work in progress)

	Arnd <><
