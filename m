Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVI0LkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVI0LkE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 07:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVI0LkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 07:40:04 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:4944 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964908AbVI0LkB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 07:40:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JHz43DgruNQVQwEIk01znhaXGCd5lFZYBav11i+RrsyiKE/siH5tqaZwooHR1L7mG90sFs/JDrqigFDJschSODrd+SmkVmsEFKbhNxs1Sy7ma4qgTQvm9xarjoI2EGap2DFdv3m2ghDyn7EGPRYPdVA7EfY+DgPxB+y5Kzs1Nvg=
Message-ID: <64c7635405092704404019b9a6@mail.gmail.com>
Date: Tue, 27 Sep 2005 17:10:00 +0530
From: Block Device <blockdevice@gmail.com>
Reply-To: Block Device <blockdevice@gmail.com>
To: Fawad Lateef <fawadlateef@gmail.com>
Subject: Re: Trapping Block I/O
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1e62d137050923103843058e92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64c7635405092305433356bd17@mail.gmail.com>
	 <1e62d137050923103843058e92@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem to creating a wrapper in the manner sugegsted is that
any filesystems mounted or other stuff which uses the original device
must be stopped
and changed to start using the new pseudo device. I want something
which can be as
non intrusive as possible. Am looking @ Jens btrace :) ..

Thanks &Regards
-BD


On 9/23/05, Fawad Lateef <fawadlateef@gmail.com> wrote:
> On 9/23/05, Block Device <blockdevice@gmail.com> wrote:
> >
> >     I need to trap _all_ the I/O going to each and every block device
> > in the system. I used jprobes to trap calls to generic_make_request.
> > Is this the correct/only place to do such a thing ?
> > Or do I have to monitor the q->make_request_fn for every device ?
> >
>
> Yes, generic_make_request or monitoring q->make_request_fn can trap
> the _all_ I/O tpo block devices but other approach might be a little
> bit odd/difficult but through that you can get every request to block
> device .... the approach is you create a block device and then create
> that block device as a wrapper on your device, now use your block
> device and in its request function (can alter the data and sectors
> etc) and calls generic_make_request for the original device on which
> you created wrapper .... So by doing this you can easily monitor
> requests (similar to this approach is used in LVM/RAID) ......
>
>
> --
> Fawad Lateef
>
