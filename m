Return-Path: <linux-kernel-owner+w=401wt.eu-S1423138AbWLVAO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423138AbWLVAO4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 19:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423139AbWLVAO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 19:14:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:25068 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423138AbWLVAOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 19:14:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qzgGp0468qXYf6HsTtx1y/55xw430LIrUOuwvqq0jwQ5Y4vsiHY6dS3kFJk7CO4N1nFCEJRsqZlfgIyIa4X4Zm35QlMfuuSpXj1Fk9iJTAJk8wBOZoi2/kE5k2rl/xUvTeu3N7gpY89PZRpyWo1dsqB9HfmJd3HXNRk9f3JPqxM=
Message-ID: <7d15175e0612211614y3ce090fcn38cbcaced76b1024@mail.gmail.com>
Date: Fri, 22 Dec 2006 05:44:54 +0530
From: "Bhanu Kalyan Chetlapalli" <chbhanukalyan@gmail.com>
To: "Manish Regmi" <regmi.manish@gmail.com>
Subject: Re: Linux disk performance.
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <652016d30612200317i6d33d097xe55971750e83cd97@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
	 <1166431020.3365.931.camel@laptopd505.fenrus.org>
	 <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
	 <20061218130702.GA14984@gateway.home>
	 <652016d30612182222h7fde4ea5jbc0927c8ebeae76a@mail.gmail.com>
	 <458788D7.2070107@yahoo.com.au>
	 <652016d30612200317i6d33d097xe55971750e83cd97@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Manish Regmi <regmi.manish@gmail.com> wrote:
> On 12/19/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > When you submit a request to an empty block device queue, it can
> > get "plugged" for a number of timer ticks before any IO is actually
> > started. This is done for efficiency reasons and is independent of
> > the IO scheduler used.
> >
>
> Thanks for the information..
>
> > Use the noop IO scheduler, as well as the attached patch, and let's
> > see what your numbers look like.
> >
>
> Unfortunately i got the same results even after applying your patch. I
> also tried putting
> q->unplug_delay = 1;
> But it did not work. The result was similar.

I am assuming that your program is not seeking inbetween writes.

Try disabling the Disk Cache, now-a-days some disks can have as much
as 8MB write cache. so the disk might be buffering as much as it can,
and trying to write only when it can no longer buffer. Since you have
an app which continously write copious amounts of data, in order,
disabling write cache might make some sense.

> --
> ---------------------------------------------------------------
> regards
> Manish Regmi
>
Bhanu
> ---------------------------------------------------------------
> UNIX without a C Compiler is like eating Spaghetti with your mouth
> sewn shut. It just doesn't make sense.
>
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
>
>


-- 
There is only one success - to be able to spend your life in your own way.
