Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWHXKn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWHXKn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWHXKn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:43:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57222 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751085AbWHXKn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:43:57 -0400
Subject: Re: [PATCH 4/6] BC: user interface (syscalls)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <20060823213512.88f4344d.akpm@osdl.org>
References: <44EC31FB.2050002@sw.ru> <44EC369D.9050303@sw.ru>
	 <44EC5B74.2040104@sw.ru> <20060823095031.cb14cc52.akpm@osdl.org>
	 <1156354182.3007.37.camel@localhost.localdomain>
	 <20060823213512.88f4344d.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 12:04:16 +0100
Message-Id: <1156417456.3007.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-23 am 21:35 -0700, ysgrifennodd Andrew Morton:
> > Its a uid_t because of setluid() and twenty odd years of existing unix
> > practice. 
> > 
> 
> I don't understand.  This number is an identifier for an accounting
> container, which was somehow dreamed up by userspace.

Which happens to be a uid_t. It could easily be anyother_t of itself and
you can create a container_id_t or whatever. It is just a number. 

The ancient Unix implementations of this kind of resource management and
security are built around setluid() which sets a uid value that cannot
be changed again and is normally used for security purposes. That
happened to be a uid_t and in simple setups at login uid = luid = euid
would be the norm.

Thus the Linux one happens to be a uid_t. It could be something else but
for the "container per user" model whatever a container is must be able
to hold all possible uid_t values. So we can certainly do something like

typedef uid_t	container_id_t;


Alan

