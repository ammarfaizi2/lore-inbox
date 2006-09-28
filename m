Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWI1Eof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWI1Eof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 00:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWI1Eof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 00:44:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751403AbWI1Eoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 00:44:34 -0400
Date: Wed, 27 Sep 2006 21:44:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>, linux-scsi@vger.kernel.org,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Illustration of warning explosion silliness
Message-Id: <20060927214428.9e5c0e79.akpm@osdl.org>
In-Reply-To: <20060927213628.ef12b1ed.akpm@osdl.org>
References: <20060928005830.GA25694@havoc.gtf.org>
	<20060927183507.5ef244f3.akpm@osdl.org>
	<451B29FA.7020502@garzik.org>
	<20060927203417.f07674de.akpm@osdl.org>
	<451B4D58.9070401@garzik.org>
	<20060927213628.ef12b1ed.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 21:36:28 -0700
Andrew Morton <akpm@osdl.org> wrote:

> device_for_each_child() 

All that being said, device_for_each_child() is rather broken by design. 
It walks a list of items applying a function to them and bales out on
first-error.

There's no way in which the caller can know which items have been operated
on, nor which items have yet to be operated on, nor which item experienced
the failure.  Any caller which is serious about error recovery presumably
won't use it, unless the callback function happens to be something which
makes no state changes.
