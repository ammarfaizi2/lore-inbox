Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031168AbWI1BmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031168AbWI1BmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031172AbWI1BmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:42:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031168AbWI1BmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:42:15 -0400
Date: Wed, 27 Sep 2006 18:42:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] device_for_each_child(): kill pointless warning noise
Message-Id: <20060927184200.7d7b9cc2.akpm@osdl.org>
In-Reply-To: <20060928010518.GA25865@havoc.gtf.org>
References: <20060928010518.GA25865@havoc.gtf.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 21:05:18 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> As the last patch demonstrated, it is quite valid for a caller to ignore
> the return value of device_for_each_child(), given that the return value
> is wholly dependent on the actor -- which in practice often has a
> hardcoded return value.

Yes, but almost all of the instances which you found are flat-out *wrong*. 
They're returning 0 or 1 at random places in the callchain because they're
calling intermediate void-returning functions which are themselves dropping
error codes on the floor instead of returning them.

Let no error go unhandled!
