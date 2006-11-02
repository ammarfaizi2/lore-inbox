Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752608AbWKBAYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbWKBAYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbWKBAYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:24:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:681 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752608AbWKBAYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:24:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FyzVBpNNQZp8ZK5DC4e4upYe2rIfUNsELg6jS7QRyZ8B+71VjJUxhvfuhiF/WXZ/set1t0PhzgluUF/v+9fh1vuGO+r1/An+flHoIQTZEZ8QTnycsCszsLSU2MYwD/bWAl++HSugrU29Q8c2NztAv3CWfMRJo+x0nNGpYqmOgtA=
Message-ID: <9a8748490611011624m36be7d75x898f2e093e8fd422@mail.gmail.com>
Date: Thu, 2 Nov 2006 01:24:09 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in several drivers
Cc: "Neil Horman" <nhorman@tuxdriver.com>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>, akpm@osdl.org,
       kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061101161155.d7b30258.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
	 <1161660875.10524.535.camel@localhost.localdomain>
	 <20061024125306.GA1608@hmsreliant.homelinux.net>
	 <1161729762.10524.660.camel@localhost.localdomain>
	 <20061101135619.GA3459@hmsreliant.homelinux.net>
	 <9a8748490611011605u55ccdcaeob99700d6e1a813a4@mail.gmail.com>
	 <20061101161155.d7b30258.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Thu, 2 Nov 2006 01:05:49 +0100 Jesper Juhl wrote:
>
> > On 01/11/06, Neil Horman <nhorman@tuxdriver.com> wrote:
> > > Hey all-
> > >         Since Andrew hasn't incorporated this patch yet, and I had the time, I
> > > redid the patch taking Benjamin's INIT_LIST_HEAD and Joes mmtimer cleanup into
> > > account.  New patch attached, replacing the old one, everything except the
> > > aforementioned cleanups is identical.
> > >
> > > Thanks & Regards
> > > Neil
> > >
> > > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > >
> > > +out4:
> > > +       for_each_online_node(node) {
> > > +               kfree(timers[node]);
> > > +       }
> > > +out3:
> > > +       misc_deregister(&mmtimer_miscdev);
> > > +out2:
> > > +       free_irq(SGI_MMTIMER_VECTOR, NULL);
> > > +out1:
> > > +       return -1;
> >
> > Very nitpicky little thing, but shouldn't the labels start at column
> > 1, not column 0 ?
> > I thought that was standard practice (apparently labels at column 0
> > can confuse 'patch').
> >
> > Hmm, I guess that should be defined once and for all in
> > Documentation/CodingStyle
>
> I have some other CodingStyle changes to submit, but feel free
> to write this one up.
>
> However, I didn't know that we had a known style for this, other
> than "not indented so far that it's hidden".
>
> If a label in column 0 [0-based :] confuses patch, then that's
> a reason, I suppose.  I wasn't aware of that one...
> In a case like that, we usually say "fix the tool then."
>

Well, I am not entirely sure what confusion it is supposed to cause,
but comments such as this one suggests that there are some known
cases: http://lkml.org/lkml/2005/9/16/213
And in addition, it something that I recall having seen lots of
comments on on LKML, so I just assumed that there is some truth to it.
That is again backed by the circumstantial evidence that many files
actually do place labels at column 1 currently.

(lots of hand waving going on here, I know)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
