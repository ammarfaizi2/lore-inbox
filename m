Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293125AbSCEXSO>; Tue, 5 Mar 2002 18:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293151AbSCEXSF>; Tue, 5 Mar 2002 18:18:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:26498 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293125AbSCEXRw>; Tue, 5 Mar 2002 18:17:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Tue, 5 Mar 2002 18:16:57 -0500
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0203051433400.1475-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.44.0203051433400.1475-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020305231747.5F95B3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 March 2002 05:39 pm, Davide Libenzi wrote:
> On Tue, 5 Mar 2002, Rusty Russell wrote:
> > +	pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
> > +
> > +	/* Must be "naturally" aligned, and not on page boundary. */
> > +	if ((pos_in_page % __alignof__(atomic_t)) != 0
> > +	    || pos_in_page + sizeof(atomic_t) > PAGE_SIZE)
> > +		return -EINVAL;
>
> How can this :
>
> 	(pos_in_page % __alignof__(atomic_t)) != 0
>
> to be false, and together this :
>
> 	pos_in_page + sizeof(atomic_t) > PAGE_SIZE
>
> to be true ?
> This is enough :
>
> 	if ((pos_in_page % __alignof__(atomic_t)) != 0)
>
>

I believe not all machine have  alignof  == sizeof
>
>
> - Davide
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
