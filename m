Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311270AbSC1BBS>; Wed, 27 Mar 2002 20:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311271AbSC1BBI>; Wed, 27 Mar 2002 20:01:08 -0500
Received: from hermes.toad.net ([162.33.130.251]:5547 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S311270AbSC1BBB>;
	Wed, 27 Mar 2002 20:01:01 -0500
Subject: Re: proc_file_read() hack?
From: Thomas Hood <jdthood@mail.com>
To: Todd Inglett <tinglett@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CA20EDF.7080402@vnet.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 27 Mar 2002 20:02:20 -0500
Message-Id: <1017277343.865.32.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-03-27 at 13:26, Todd Inglett wrote:
> I guess I don't understand the conflict.

There are three cases:
0)  start == 0
1)  0 < start < buffer
2)  start >= buffer

These exhaust all the possible values that can be returned
in *start.

You propose to change the code so that there are three cases:
0)  start == 0
1') 0 < start < PROC_BLOCK_SIZE
2'/3) start >= PROC_BLOCK_SIZE

However, we can't make the change you propose because it would
break functions that use case #1 with a *start value greater
than PROC_BLOCK_SIZE.

>... is there a chance that start >= PROC_BLOCK_SIZE (but start < page)
> in case #1?

Yes.

> If that is true I am wondering how it could possibly be correct
> since start will be used as a length which is greater than the
> size of the page.

start will be used as an offset, not as a length.

If you think the hack was a bad idea, I agree with you.
But we can't change it without auditing all the proc read
functions that use case #1.

--
Thomas Hood

