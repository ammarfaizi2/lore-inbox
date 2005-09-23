Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVIWRiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVIWRiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVIWRiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:38:19 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:59664 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751117AbVIWRiS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:38:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N3bkPreZJUVop7r1cEYPTimBOVrqGiZxC+ozrmGjhEXRUT0E+gSpyNRiJ/EIBlACjDuJhUGk03Hg+tKcc/VoaWaYuYrFY3eu5JkiqT9elZolJT7FmR/oICSgbktbXUpVhHDkQeXtL/gR8SdePITydyAhu9KO+gtWC92l9WXsthQ=
Message-ID: <1e62d137050923103843058e92@mail.gmail.com>
Date: Fri, 23 Sep 2005 22:38:17 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: Block Device <blockdevice@gmail.com>
Subject: Re: Trapping Block I/O
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <64c7635405092305433356bd17@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64c7635405092305433356bd17@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Block Device <blockdevice@gmail.com> wrote:
>
>     I need to trap _all_ the I/O going to each and every block device
> in the system. I used jprobes to trap calls to generic_make_request.
> Is this the correct/only place to do such a thing ?
> Or do I have to monitor the q->make_request_fn for every device ?
>

Yes, generic_make_request or monitoring q->make_request_fn can trap
the _all_ I/O tpo block devices but other approach might be a little
bit odd/difficult but through that you can get every request to block
device .... the approach is you create a block device and then create
that block device as a wrapper on your device, now use your block
device and in its request function (can alter the data and sectors
etc) and calls generic_make_request for the original device on which
you created wrapper .... So by doing this you can easily monitor
requests (similar to this approach is used in LVM/RAID) ......


--
Fawad Lateef
