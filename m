Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWA3StH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWA3StH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWA3StH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:49:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:18634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964864AbWA3StF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:49:05 -0500
Date: Mon, 30 Jan 2006 10:43:02 -0800
From: Greg KH <greg@kroah.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
Message-ID: <20060130184302.GA17457@kroah.com>
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com> <20060129190539.GA26794@kroah.com> <m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com> <20060130045153.GC13244@kroah.com> <43DDA1E7.5010109@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DDA1E7.5010109@cosmosbay.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 06:19:35AM +0100, Eric Dumazet wrote:
> Example of improvement in kref_put() :
> 
> [PATCH] kref : Avoid an atomic operation in kref_put() when the last 
> reference is dropped. On most platforms, atomic_read() is a plan read of 
> the counter and involves no atomic at all.

No, we wat to decrement and test at the same time, to protect against
any race where someone is incrementing right when we are dropping the
last reference.

So, thanks, but I'm not going to apply this.

greg k-h
