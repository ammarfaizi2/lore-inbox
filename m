Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272392AbTGYXt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 19:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272393AbTGYXtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 19:49:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48512
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S272392AbTGYXtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 19:49:20 -0400
Subject: Re: [PATCH] Remove module reference counting.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, davem@redhat.com, arjanv@redhat.com,
       Linus Torvalds <torvalds@transmeta.com>, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030725122651.4aedc768.shemminger@osdl.org>
References: <20030725173900.D7DE12C2A9@lists.samba.org>
	 <20030725122651.4aedc768.shemminger@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059175489.1206.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jul 2003 00:24:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-25 at 20:26, Stephen Hemminger wrote:
> > 	If module removal is to be a rare and unusual event, it
> > doesn't seem so sensible to go to great lengths in the code to handle
> > just that case.  In fact, it's easier to leave the module memory in
> > place, and not have the concept of parts of the kernel text (and some
> > types of kernel data) vanishing.

Uggh. There is a difference between taking the approach that some stuff
is hard to handle and gets into trouble for using MOD_INC/DEC so is
unsafe, and doing the locking from the caller, or arranging that you
know the device is quiescent in the unload path and not allowing
unloading to work properly.

I've got drivers that use MOD_INC/DEC and are technically unsafe, they
by default now don't unload and its an incentive to fix them. I'd hate
to have my box cluttering up and have to keep rebooting to test drivers
because of inept implementations however.


