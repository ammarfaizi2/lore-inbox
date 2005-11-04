Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVKDSiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVKDSiE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVKDSiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:38:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750813AbVKDSiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:38:03 -0500
Date: Fri, 4 Nov 2005 10:37:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: AHERRMAN@de.ibm.com, viro@ftp.linux.org.uk, heicars2@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-Id: <20051104103743.16f0ee06.akpm@osdl.org>
In-Reply-To: <20051104174506.GA4720@devserv.devel.redhat.com>
References: <OFDDB8F7D0.1B3A39C6-ONC12570AF.00570609-C12570AF.005739CC@de.ibm.com>
	<20051104094212.23f07ce7.akpm@osdl.org>
	<20051104174506.GA4720@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> On Fri, Nov 04, 2005 at 09:42:12AM -0800, Andrew Morton wrote:
>  > Andreas Herrmann <AHERRMAN@de.ibm.com> wrote:
>  > >
>  > > Obviously you missed the point that (depending on the compiler version,
>  > >  options etc.) do_move_mount() and do_add_mount() can be inlined.
>  > 
>  > I think we found a way of preventing the 3.x compiler from doing that.  Arjan,
>  > do you recall where we ended up with that problem?
> 
>  it was mostly caused by -funit-at-a-time that caused 3.x to go haywire. You
>  need to turn that off in general.

In that case, does s390 still have a problem that we need to be solving here?

(s390 doesn't implement CONFIG_DEBUG_STACK_USAGE.  Suggest you do so, then
stick a dump_stack() into do_exit()).

(dm is still doing very risky things though)
