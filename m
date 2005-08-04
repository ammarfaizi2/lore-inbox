Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVHDKO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVHDKO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 06:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVHDKO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 06:14:26 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:4704 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262458AbVHDKOZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:14:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A0UbYk5v46jwKS93voHRvc4mT84UQwkaLhp2zBiFe0BsgG6Yt+auX2ERxMAmQ+CRbeweFguh+hCo47Rra/wUSTWy3XAk3vkv/bSsltZMer9QYmnTOYjYhEs1fwnCsq69XUXN3WQUnPu+0IzbX5SERf0K8ddbBXiqgQS6OyzBnKw=
Message-ID: <7d15175e05080403145a151b79@mail.gmail.com>
Date: Thu, 4 Aug 2005 15:44:24 +0530
From: Bhanu Kalyan Chetlapalli <chbhanukalyan@gmail.com>
To: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
Subject: Re: opening linux char device file in user thread.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0508041317360.5451@lantana.cs.iitm.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.60.0508041317360.5451@lantana.cs.iitm.ernet.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/05, P.Manohar <pmanohar@lantana.cs.iitm.ernet.in> wrote:
> 
> hai,
> 
>    I have written a daemon which is running in user space, will send some
> data periodically to kernel space. This I have done with the help of a
> device file.
> 
>  It is working, but I want to apply threads mechanism in that daemon. But
> when I split that daemon functionality into a thread and a original
> process. I am unable to
> open the device file. This is happening in both places(either in thread or
> original process).

Try opening the device, get the FD and THEN spawn the thread. this
will help, as the device is opened only once as far as the driver is
concerned. The presence of usage from the thread is felt only in the
reference count of the fd (which should be transparent to user space
and the device driver). Race conditions are assumed to be taken care
of in the kernel module though.

The other way is to open device, write data, close device every time u
write something. This is beneficial if the time between the writes is
seperated by more than a minute. There will be no races etc to take
care of.
 
> The device is opening  when threading is not there.
> 
> Can anybody suggest me?
> 
> Regards,
> P.Manohar.
> 

Bhanu.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The difference between Theory and Practice is more so in Practice than
in Theory.
