Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285704AbSADX04>; Fri, 4 Jan 2002 18:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285709AbSADX0r>; Fri, 4 Jan 2002 18:26:47 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6917 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285704AbSADX0j>; Fri, 4 Jan 2002 18:26:39 -0500
Message-ID: <3C363913.DA9CABCF@zip.com.au>
Date: Fri, 04 Jan 2002 15:21:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
        riel@surriel.com, mjc@kernel.org, bcrl@redhat.com
Subject: Re: hashed waitqueues
In-Reply-To: <20020104094049.A10326@holomorphy.com> <3C3635A8.447EE52E@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> > +       /*
> > +        * Although the default semantics of wake_up() are
> > +        * to wake all, here the specific function is used
> > +        * to make it even more explicit that a number of
> > +        * pages are being waited on here.
> > +        */
> > +       if(waitqueue_active(page_waitqueue(page)))
> > +               wake_up_all(page_waitqueue(page));
> ...
> 
> Also, why wake_up_all()?  That will wake all tasks which are sleeping
> in __lock_page(), even though they've asked for exclusive wakeup
> semantics.  Will a bare wake_up() here not suffice?
> 

Doh.  It helps to read the comment.  Suggest that __lock_page()
be changed to use add_wait_queue().

-
