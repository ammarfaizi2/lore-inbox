Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUHAAef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUHAAef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUHAAef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:34:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:11947 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263851AbUHAAee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:34:34 -0400
Subject: Re: How to do IO across hardsector boundries
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <410C37B7.3010504@zensonic.dk>
References: <410C37B7.3010504@zensonic.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091316727.7486.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 01 Aug 2004 00:32:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-01 at 01:22, Thomas S. Iversen wrote:
> So my question really is, how do I go about updating for instance the 
> 512 bytes located for at byte 64 to 64+511 on the actual media without 
> getting in trouble regarding the data from offset 0-63 and 64+512->1023?

If you want to use the BIO layer then you need to read the two blocks,
write to the bits you care about and then write them back. That is what
will always have to happen at a lower level for this anyway. In essence
you would be implementing the small g_read/g_write equivalent routines.


