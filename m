Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267664AbUIOWfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267664AbUIOWfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbUIOWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:34:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:17093 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267660AbUIOWcL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:32:11 -0400
Subject: Re: [PATCH] hvc_console fix to protect hvc_write against ldisc
	write after hvc_close
From: Ryan Arnold <rsa@us.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040915204107.GA26776@thunk.org>
References: <1095273835.3294.278.camel@localhost>
	 <20040915204107.GA26776@thunk.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1095287748.3294.423.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 17:35:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 15:41, Theodore Ts'o wrote:
> The current (I can't speak to what Alan Cox is going to change) rules
> with tty drivers is that tty drivers are supposed to close the line
> discpline in their close routines.  That's the much safer and cleaner
> way of fixing this problem, and it is in line with what most of the
> other tty drivers are doing.
				- Ted

Thanks for the pointer Ted.  I've looked through the drivers/char
directory but I must be blind because all I see other drivers doing is
setting tty->closing = 1 (and then = 0 later) and
ldsic->flush_buffer().  Is flush_buffer() what you're refering to?  The
tty->closing variable just seems to prevent the ldisc from reading.

Ryan S. Arnold
IBM Linux Technology Center

