Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262131AbSJDPyt>; Fri, 4 Oct 2002 11:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbSJDPyt>; Fri, 4 Oct 2002 11:54:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43793 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262131AbSJDPys>;
	Fri, 4 Oct 2002 11:54:48 -0400
Date: Fri, 4 Oct 2002 17:00:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add safe version of list_for_each_entry() to list.h
Message-ID: <20021004170021.F18545@parcelfarce.linux.theplanet.co.uk>
References: <OFDA00C8D3.E99FDDA0-ON85256C48.005322C4@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFDA00C8D3.E99FDDA0-ON85256C48.005322C4@pok.ibm.com>; from peloquin@us.ibm.com on Fri, Oct 04, 2002 at 10:48:33AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 10:48:33AM -0500, Mark Peloquin wrote:
> list_empty() can be used on check list heads *or*
> to check if a list element is currently in a list,
> assuming the coder uses list_del_init(). However,
> if the coder chooses to use list_del() [which sets
> the prev and next fields to 0] instead, there is no
> corresponding function to indicate if that element
> is currently on a list. This function does that.

That behaviour for list_del is new and, IMNSHO, bogus.  There's now _zero_
gain in using list_del instead of list_del_init.  akpm changed it about
5 months ago with a comment that says:

"list_head debugging"

so i think it's pretty safe to assume that this behaviour will not
remain into 2.6.  if you think you want list_member, use list_del_init
and list_empty() instead.

-- 
Revolutions do not require corporate support.
