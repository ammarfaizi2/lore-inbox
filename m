Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUIJQbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUIJQbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUIJQa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:30:29 -0400
Received: from the-village.bc.nu ([81.2.110.252]:47793 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267543AbUIJQYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:24:01 -0400
Subject: Re: The Serial Layer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040910143211.GA7342@thunk.org>
References: <1094582980.9750.12.camel@localhost.localdomain>
	 <1094587598.2801.24.camel@laptop.fenrus.com>
	 <1094584456.9745.14.camel@localhost.localdomain>
	 <20040909125705.GA5658@thunk.org>
	 <1094747324.14623.49.camel@localhost.localdomain>
	 <20040910143211.GA7342@thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094829666.17464.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 16:21:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 15:32, Theodore Ts'o wrote:
> We needed to close the line discpline in order to prevent a line
> discipline (such as ppp) from trying to write to the tty.  Given there
> was an invariant that a tty always had a line discpline always, we
> reassigned it back to N_TTY.  The right answer is probably to be to
> add checks to the line discpline code before they attempt to send data
> to the tty.

Ok that makes sense. So we need the same kind of ordering rules about
device->close() as we now enforce with ldisc->close(). That suggests we
simply need to call ldisc->close before device->close. I think we can
now do that safely as the device won't deliver data to a closed ldisc.

Will look into it

