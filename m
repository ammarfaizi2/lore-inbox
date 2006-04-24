Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWDXWp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWDXWp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWDXWp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:45:59 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:60625 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751343AbWDXWp6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:45:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mlz+3MIUm0YoL1ZfK4qtABzdvkMCAyQ2Q9jP4nQ2nWxawzEmiQdYgUazMHQxBDoWs3BKsMaVJ0aL1ehun9hgyPVS7hij+8alhordk089eU9qUmKp9xWy3qf3S7w8BmMcHj3OdyCQMqvNKqLEBmHneVAIr0tKUCFfay0NLvzpLYs=
Message-ID: <9f7850090604241545y59143fb1ydb7cfea760498581@mail.gmail.com>
Date: Mon, 24 Apr 2006 15:45:57 -0700
From: "marty fouts" <mf.danger@gmail.com>
To: "Martin Mares" <mj@ucw.cz>
Subject: Re: Compiling C++ modules
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
In-Reply-To: <mj+md-20060424.220809.6996.atrey@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	 <1145911546.1635.54.camel@localhost.localdomain>
	 <444D3D32.1010104@argo.co.il>
	 <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>
	 <9f7850090604241450w885fa98v36657ba5f12f071c@mail.gmail.com>
	 <mj+md-20060424.220809.6996.atrey@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/06, Martin Mares <mj@ucw.cz> wrote:
> Hello!
>
> > Oh, and yeah, a = b + c *is* more readable than
> >
> > a = malloc(strlen(b) + strlen(c));
> > strcpy(a,b);
> > strcat(a,c);
> >
> > and contains fewer bugs ;)
>
> Actually, it contains at least the bug you have made in your C example,
> that is forgetting that malloc() can fail. So can string addition, if
> allocated dynamically.

It's too small of a fragment to tell whether or not appropriate
exception handling has been set up, but yeah, it needs a try/catch to
be safe.  That's *1* of the bugs in the c example.  It's the one they
share.

It's not the only one in the C code, though, as Willy Tarreau pointed
out, the malloc idiom is wrong, since it doesn't allocate space for
the terminating null.

Of course, the C fragment has the implicit problem of who will do the
associated free to avoid the memory leak, where the C++ fragment has
the issue of garbage collection...
