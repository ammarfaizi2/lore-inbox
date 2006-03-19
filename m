Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWCSEKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWCSEKe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 23:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWCSEKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 23:10:34 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:26655 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750778AbWCSEKe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 23:10:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q3IgnZUzFSNtpm4QHHk4NmsJmxTrzJotXkJeubpUJ3bmVhq9QEFYSKrehDrR3wPc0sPOUN1BV0KwMbKwq5YqstFvWS2As9Lye8hK1e5o65fiOe/R/gAuZH9x8XegxM0AdS9+den93ekMBPD0LNVJTfabPVVt0oWAuhlm78LeA2c=
Message-ID: <9e4733910603182010p394c3233p81825b093fb693c@mail.gmail.com>
Date: Sat, 18 Mar 2006 23:10:33 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wu Fengguang" <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] Adaptive read-ahead V11
In-Reply-To: <20060319034750.GA8732@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060319023413.305977000@localhost.localdomain>
	 <9e4733910603181910p21117f3anc107673e31f6352b@mail.gmail.com>
	 <20060319034750.GA8732@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/06, Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> On Sat, Mar 18, 2006 at 10:10:43PM -0500, Jon Smirl wrote:
> > This is probably a readahead problem. The lighttpd people that are
> > encountering this problem are not regular lkml readers.
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=5949
>
> [QUOTE]
>         My general conclusion is that since they were able to write a user
>         space implementation that avoids the problem something must be broken
>         in the kernel readahead logic for sendfile().
>
> Maybe the user space solution does the trick by using a larger window size?
>
> IMHO, the stock read-ahead is not designed with extremely high concurrency in
> mind. However, 100 streams should not be a problem at all.

Has anyone checked to see if the readahead logic is working as
expected from sendfile? IO from sendfile is a different type of
context than IO from user space, there could be sendfile specific
problems. If window size is the trick, shouldn't sendfile
automatically adapt it's window size? I don't think you can control
the sendfile window size from user space.

The goal of sendfile is to be the most optimal way to send a file over
the network. This is a case where user space code is easily beating
it.

--
Jon Smirl
jonsmirl@gmail.com
