Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWDENrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWDENrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 09:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWDENrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 09:47:05 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:21118 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751151AbWDENrE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 09:47:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OrdmvnsyMPgEZBzu48cDRuNRySKGyb5WYp6JeMFNu2nHw92iraEdMBFU8Ns+hutZoXpM2x6oRJXGN9Q2oP1l+uYwUS/iGic13dMqm4ccsd4PAtiUye76s50Zelazy4tYEZUgDley9Ni6PQZvS8ZUHkcsk9JxkYmgmQKDrHC7GXw=
Message-ID: <4745278c0604050646n668bc9fy2b8c18462439ae5d@mail.gmail.com>
Date: Wed, 5 Apr 2006 09:46:58 -0400
From: "Vishal Patil" <vishpat@gmail.com>
To: "Antonio Vargas" <windenntw@gmail.com>
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
Cc: "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <69304d110604050448x60fd5bb1ub74f66b720dc7d8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com>
	 <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com>
	 <4432D6D4.2020102@tmr.com>
	 <4745278c0604041402n5c6329ebw71d7fdc5c3a9dd68@mail.gmail.com>
	 <69304d110604050448x60fd5bb1ub74f66b720dc7d8a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The two queues are used for sorting purposes ONLY. There is the
dispatch queue to which the requests are moved from one of the queues
and the request is processes of the dispatch queue.

Example:

Current request  = 40
Q1 = 55 58 67 72
Q2 = 10 23 38

Assuming no other request arrives, these will be pushed on the
dispatch queue in the following order
55 58 67 72 10 23 38

I hope this clears things up.

Also I have found that the patch that I had submitted earlier has few
bugs in it. I am going to fix those and then submit a patch for 2.6.16
Thanks.


- Vishal



On 4/5/06, Antonio Vargas <windenntw@gmail.com> wrote:
> On 4/4/06, Vishal Patil <vishpat@gmail.com> wrote:
> > In that case it would be a normal elevator algorithm and that has a
> > possiblity of starving the requests at one end of the disk.
> >
> > - Vishal
> >
> > On 4/4/06, Bill Davidsen <davidsen@tmr.com> wrote:
> > > Vishal Patil wrote:
> > > > Maintain two queues which will be sorted in ascending order using Red
> > > > Black Trees. When a disk request arrives and if the block number it
> > > > refers to is greater than the block number of the current request
> > > > being served add (merge) it to the first sorted queue or else add
> > > > (merge) it to the second sorted queue. Keep on servicing the requests
> > > > from the first request queue until it is empty after which switch over
> > > > to the second queue and now reverse the roles of the two queues.
> > > > Simple and Sweet. Many thanks for the awesome block I/O layer in the
> > > > 2.6 kernel.
> > > >
> > > Why both queues sorting in ascending order? I would think that one
> > > should be in descending order, which would reduce the seek distance
> > > between the last i/o on one queue and the first on the next.
> > >
>
> But, if there are two queues, one which is being processed and other
> which gets the new requests (and the corresponding queue switch when
> the current is empty), then there is no way to get starved when they
> are sorted in opposite order.
>
>
> --
> Greetz, Antonio Vargas aka winden of network
>
> http://wind.codepixel.com/
> windNOenSPAMntw@gmail.com
> thesameasabove@amigascne.org
>
> Every day, every year
> you have to work
> you have to study
> you have to scene.
>


--
Every passing minute is another chance to turn it all around.
