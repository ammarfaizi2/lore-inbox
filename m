Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTGKVdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTGKVdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:33:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52920
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262464AbTGKVde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:33:34 -0400
Subject: SECURITY - data leakage due to incorrect strncpy implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.44.0307112100240.843-100000@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0307112100240.843-100000@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057959932.20637.51.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 22:45:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 20:04, Mikulas Patocka wrote:
> What's the difference there? strlcpy always creates null-terminated
> string, strncpy doesn't. strncpy in kernel (unlike user strncpy) does not
> pad the whole destination buffer with zeros (see comment and
> implementation in lib/string.c), so I don't see any point why strncpy
> should be more secure.

Lots of kernel drivers rely on the libc definition of strncpy. 

Lets update the bug report to "2.4 and 2.5 both leak arbitary kernel data
to user space" tho thankfully in small pieces. Fix required. (bcc'd to Mark to 
assign a CAN number)

And for 2.4-ac I'm going to simply go make strncpy do what it says in the
book. For 2.5 the same is true and cleaner (since those who use strlcpy
properly don't take any performance hit). Actually it may make sense to 
backport strlcpy for those odd performance critical ones.

I don't think its that serious a bug - the odds of getting a critical bit of
someone elses data are remarkably low but it wants fixing.

Alan

