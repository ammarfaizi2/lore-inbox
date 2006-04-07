Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWDGQEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWDGQEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 12:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWDGQEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 12:04:53 -0400
Received: from wproxy.gmail.com ([64.233.184.234]:36046 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932362AbWDGQEw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 12:04:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SZ4/2D0Pn8eSRN5do3mOQXUeTWKn/E54xVNHNmUvN0Tw7UAycKDytDxH4eN7eBMp+WSPzvUuuwAN0F5ROMF1xj1n7OUl7HRQujnjMyzzOWReoYxItF7z1kSWYtEi1K+atqoVTazTEdobkSbn6URHOf98D4ikRUJf8ckZDZNwOb0=
Message-ID: <4ae3c140604070904j51d1b968l2f62a1de647c0b02@mail.gmail.com>
Date: Fri, 7 Apr 2006 12:04:51 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to know when file data has been flushed into disk?
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <87slop1ix2.fsf@suzuka.mcnaught.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140604070842x537353c4s9a60706c2a2d25d9@mail.gmail.com>
	 <87slop1ix2.fsf@suzuka.mcnaught.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

That make sense. But at least ext3 needs to know when all data has
been flushed so that it can commit the meta data. Question is how can
ext3 knows that? The data flushing is done by flush daemon. There go
to be some way to notify ext3 that data is flushed. Where  is this
part of code in ext3 module?

Xin

On 4/7/06, Douglas McNaught <doug@mcnaught.org> wrote:
> "Xin Zhao" <uszhaoxin@gmail.com> writes:
>
> > 3. Does sys_close() have to  be blocked until all data and metadata
> > are committed? If not, sys_close() may give application an illusion
> > that the file is successfully written, which can cause the application
> > to take subsequent operation. However, data flush could be failed. In
> > this case, file system seems to mislead the application. Is this true?
> > If so, any solutions?
>
> The fsync() call is the way to make sure written data has hit the
> disk.  close() doesn't guarantee that.
>
> -Doug
>
