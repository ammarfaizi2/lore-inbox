Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWCSPxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWCSPxs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWCSPxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:53:48 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:12132 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932137AbWCSPxr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:53:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s59d5IPa+SU8ctlquvr9MP2feiPW/jTXzoU47WRqgb8SRNB2nfnTsoDUw04pDS8JK7TLF85bRBav3ELT0+hueYQEnhfKiz361vP+r6nWo78XW/E9erZ+V0bR1HiKSjP8Nv7bAMFLVckex446y5S1EBMwCVmJUToAPGvyNKDQtKs=
Message-ID: <9e4733910603190753y2d36845ay8e0b08f961ade71@mail.gmail.com>
Date: Sun, 19 Mar 2006 10:53:46 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wu Fengguang" <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] Adaptive read-ahead V11
In-Reply-To: <20060319050956.GA4313@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060319023413.305977000@localhost.localdomain>
	 <9e4733910603181910p21117f3anc107673e31f6352b@mail.gmail.com>
	 <20060319034750.GA8732@mail.ustc.edu.cn>
	 <9e4733910603182010p394c3233p81825b093fb693c@mail.gmail.com>
	 <20060319050956.GA4313@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/06, Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> On Sat, Mar 18, 2006 at 11:10:33PM -0500, Jon Smirl wrote:
> > > Maybe the user space solution does the trick by using a larger window size?
> > >
> > > IMHO, the stock read-ahead is not designed with extremely high concurrency in
> > > mind. However, 100 streams should not be a problem at all.
> >
> > Has anyone checked to see if the readahead logic is working as
> > expected from sendfile? IO from sendfile is a different type of
> > context than IO from user space, there could be sendfile specific
>
> AFAIK, sendfile() and read() use the same readahead logic, which
> handles them equally good.  And there is another readaround logic
> which handles unhinted mmapped reads.

In another thread someone made a mention that this problem may have
something to do with the pools of memory being used for sendfile. The
readahead from sendfile is going into a moderately sized pool. When
you get 100 of them going at once the other threads flush the
readahead data out of the pool before it can be used and thus trigger
the thrashing seek storm. Is this true, that sendfile data is read
ahead into a fixed sized pool? If so, the readahead algorithms would
need to reduce the sendfile window sizes to stop the pool from
thrashing.

--
Jon Smirl
jonsmirl@gmail.com
