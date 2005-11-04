Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVKDRpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVKDRpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVKDRpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:45:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11984 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750765AbVKDRpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:45:18 -0500
Date: Fri, 4 Nov 2005 18:45:06 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Herrmann <AHERRMAN@de.ibm.com>, viro@ftp.linux.org.uk,
       heicars2@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-ID: <20051104174506.GA4720@devserv.devel.redhat.com>
References: <OFDDB8F7D0.1B3A39C6-ONC12570AF.00570609-C12570AF.005739CC@de.ibm.com> <20051104094212.23f07ce7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104094212.23f07ce7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 09:42:12AM -0800, Andrew Morton wrote:
> Andreas Herrmann <AHERRMAN@de.ibm.com> wrote:
> >
> > Obviously you missed the point that (depending on the compiler version,
> >  options etc.) do_move_mount() and do_add_mount() can be inlined.
> 
> I think we found a way of preventing the 3.x compiler from doing that.  Arjan,
> do you recall where we ended up with that problem?

it was mostly caused by -funit-at-a-time that caused 3.x to go haywire. You
need to turn that off in general.

the real fix is in gcc 4.x (4.1 at least) where gcc got a lot smarter about
stack slot lifetimes
