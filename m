Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWA3FgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWA3FgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 00:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWA3FgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 00:36:23 -0500
Received: from smtpout.mac.com ([17.250.248.83]:31191 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751245AbWA3FgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 00:36:22 -0500
In-Reply-To: <43DDA1E7.5010109@cosmosbay.com>
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com> <20060129190539.GA26794@kroah.com> <m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com> <20060130045153.GC13244@kroah.com> <43DDA1E7.5010109@cosmosbay.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AB74DF4E-5563-4449-8194-315AA4CCD7FE@mac.com>
Cc: Greg KH <greg@kroah.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
Date: Mon, 30 Jan 2006 00:35:14 -0500
To: Eric Dumazet <dada1@cosmosbay.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2006, at 00:19, Eric Dumazet wrote:
> -	if (atomic_dec_and_test(&kref->refcount)) {
> +	/*
> +	 * if current count is one, we are the last user and can release  
> object
> +	 * right now, avoiding an atomic operation on 'refcount'
> +	 */
> +	if ((atomic_read(&kref->refcount) == 1) ||

Uhh, I think you got this test reversed.  Didn't you mean != 1?   
Otherwise you only do the dec_and_test when the refcount is one,  
which means that you leak everything kref-ed.

> +	    (atomic_dec_and_test(&kref->refcount))) {
>  		release(kref);
>  		return 1;
>  	}

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


