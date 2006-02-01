Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWBAMoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWBAMoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWBAMoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:44:05 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:41015 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161043AbWBAMoD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:44:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mUM4BJ4CBnVBJMCg3fynEWjJgg49Mefg5OrHH7Jlxhbg/jt/4ydc23RaN2yYcECfptcyqGybvNnrDa4UKxnHl4HdyfJJ2LIwMJd9i1k1DQEoJFlHpj4lZFDqcRTIRB6nSA4LIkDxt9wX6J/DIf+qiRASjFZ3dWe4LwQ04ACqg9U=
Message-ID: <58cb370e0602010444m46a39705q4a3043778df1628d@mail.gmail.com>
Date: Wed, 1 Feb 2006 13:44:01 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [patch] SGIIOC4 limit request size
Cc: Jes Sorensen <jes@sgi.com>, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060201113607.GF152005@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <yq0vevzpi8r.fsf@jaguar.mkp.net>
	 <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com>
	 <20060201104913.GA152005@sgi.com>
	 <58cb370e0602010308o4cde24aeg8d629b1b3d45cdd3@mail.gmail.com>
	 <20060201111754.GB152005@sgi.com>
	 <58cb370e0602010326k265ef278k4010df13fb5adf8c@mail.gmail.com>
	 <20060201113607.GF152005@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Jeremy Higdon <jeremy@sgi.com> wrote:
> On Wed, Feb 01, 2006 at 12:26:26PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > I'll send a better patch tomorrow.  This one depends on a byte count
> > > multiple of 2.  Though according to the chip docs, it ignores bit 0
> > > of the byte count anyway (and the address for that matter).  So I
> > > think this is functionally correct.  But I think the xcount variable
> > > is superfluous.
> >
> > it seems so
>
> Here's one that removes xcount.  It seems to work too.
> Should we set hwif->rqsize to 256, or are we pretty safe in
> expecting that the default won't rise?  The driver should be
> able to handle more, but this ioc4 hardware is weird, and it
> probably wouldn't get tested if a general change were made :-)

The current maximum request size is:
*  256 for LBA28 and ATAPI devices
* 1024 for LBA48 devices

The maximum request size allowed by IDE driver for
LBA48 devices will change to 65536 but block layer will
continue to use 1024 as a default maximum request size,
also IIRC sgiioc4 IDE is used only for ATAPI devices.
So I think that there is no need to worry about ->rqsize.

Bartlomiej
