Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133020AbRARVN3>; Thu, 18 Jan 2001 16:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135669AbRARVNT>; Thu, 18 Jan 2001 16:13:19 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:43529 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S133020AbRARVNI>;
	Thu, 18 Jan 2001 16:13:08 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101182112.f0ILCmZ113705@saturn.cs.uml.edu>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 18 Jan 2001 16:12:48 -0500 (EST)
Cc: hch@ns.caldera.de (Christoph Hellwig),
        riel@conectiva.com.br (Rik van Riel), mingo@elte.hu,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101171659160.10878-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 17, 2001 05:13:31 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> struct kiovec2 {
>> 	int             nbufs;          /* Kiobufs actually referenced */
>> 	int             array_len;      /* Space in the allocated lists */
>> 	struct kiobuf * bufs;
>
> Any reason for array_len?
>
> Why not just 
> 
> 	int nbufs,
> 	struct kiobuf *bufs;
>
> Remember: simplicity is a virtue. 
>
> Simplicity is also what makes it usable for people who do NOT want to have
> huge overhead.
>
>> 	unsigned int    locked : 1;     /* If set, pages has been locked */
>
> Remove this. I don't think it's valid to lock the pages. Who wants to use
> this anyway?
>
>> 	/* Always embed enough struct pages for 64k of IO */
>> 	struct kiobuf * buf_array[KIO_STATIC_PAGES];	 
>
> Kill kill kill kill. 
>
> If somebody wants to embed a kiovec into their own data structure, THEY
> can decide to add their own buffers etc. A fundamental data structure
> should _never_ make assumptions like this.

What about getting rid of both that and the pointer, and just
hanging that data on the end as a variable length array?

struct kiovec2{
  int nbufs;
  /* ... */
  struct kiobuf[0];
}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
