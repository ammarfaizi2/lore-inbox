Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTESUii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTESUii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:38:38 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27379 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262918AbTESUih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:38:37 -0400
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <87he7qe979.fsf@gw.home.net>
References: <87d6igmarf.fsf@gw.home.net>
	 <1053376482.11943.15.camel@sisko.scot.redhat.com>
	 <87he7qe979.fsf@gw.home.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053377493.11943.32.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2003 21:51:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2003-05-20 at 01:46, Alex Tomas wrote:

> please, look:
> 
>   thread A                          commit thread
> 
>                         	    if (jh->b_committed_data) {
>                                 	kfree(jh->b_committed_data);
>                                         jh->b_committed_data = NULL;
>                                     }
> access for
> b_committed_data == NULL ?

Not with BKL.  Without it, yes, that's definitely a risk, and you need
some locking for the access to b_committed_data.  Without that, even if
you keep the jh->b_committed_data field valid, you risk freeing the old
copy that another thread is using.

Cheers,
 Stephen

