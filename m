Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423697AbWJaRWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423697AbWJaRWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423694AbWJaRWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:22:40 -0500
Received: from smtp-out.google.com ([216.239.33.17]:16069 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423697AbWJaRWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:22:40 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=Vq7pwknzedvXwcBosznbECRnaWFC/H11LeYJvjId5Z8GP3qOu7kzdNA3RyTwKeRE2
	CM6UQK6EBOP9+9V3Y2M0w==
Message-ID: <6599ad830610310922p61913cdaqb441a2cb718420a9@mail.gmail.com>
Date: Tue, 31 Oct 2006 09:22:25 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
In-Reply-To: <454782D2.3040208@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>
	 <6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>
	 <4545FDCD.3080107@in.ibm.com>
	 <6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>
	 <454782D2.3040208@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Balbir Singh <balbir@in.ibm.com> wrote:
>
> I am still a little concerned about how limit size changes will be implemented.
> Will the cpuset "mems" field change to reflect the changed limits?

That's how we've been doing it - increasing limits is easy, shrinking
them is harder ...

> > Page cache control is actually more essential that RSS control, in our
> > experience - it's pretty easy to track RSS values from userspace, and
> > react reasonably quickly to kill things that go over their limit, but
> > determining page cache usage (i.e. determining which job on the system
> > is flooding the page cache with dirty buffers) is pretty much
> > impossible currently.
> >
>
> Hmm... interesting. Why do you think its impossible, what are the kinds of
> issues you've run into?
>

Issues such as:

- determining from userspace how much of the page cache is really
"free" memory that can be given out to new jobs without impacting the
performance of existing jobs

- determining which job on the system is flooding the page cache with
dirty buffers

- accounting the active pagecache usage of a job as part of its memory
footprint (if a process is only 1MB large but is seeking randomly
through a 1GB file, treating it as only using/needing 1MB isn't
practical).

Paul
