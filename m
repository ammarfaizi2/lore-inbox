Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWD0PC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWD0PC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWD0PC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:02:28 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:40621 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965143AbWD0PC1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:02:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dzhsle0z88ERfIbh/zreFAHRRPXn9CX2q7wqaEvnQppYjn5A+jmrjVDSd7aBONKU4IxOFwsW3OluYcqWftppg68GsaC1dKeppg3cl4tr8sAoKIV2z5dU/O2cBzSdaAe0SwXK+Wfr/jy3taEeh1dBJWB6ZqsnmDieX8/Rj+ov67Q=
Message-ID: <84d7d9cf0604270802n308c2c9cs67ca0a7e4fbb8458@mail.gmail.com>
Date: Thu, 27 Apr 2006 23:02:26 +0800
From: "Real Oneone" <realoneone@gmail.com>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel@vger.kernel.org
Subject: Re: How to re-send out the packets captured by my hook function at NF_IP_PRE_ROUTING
In-Reply-To: <AF63F67E8D577C4390B25443CBE3B9F73C0A@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <AF63F67E8D577C4390B25443CBE3B9F73C0A@esnmail.esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply, Srinivas!

But maybe I failed to describe the problem that I am facing. It's ture
as you said that I have a module, which registers  a function to a
netfilter hook. Whenever there is an incoming packet, the function
could catch it and make some changes to it : wrap it in a new iphdr,
change the src and dst ip, etc. This is what I've done.

Now a problem comes that, how do I send it out directly? -- By
'directly', I mean to do it just in the kernel space, not first
passing it to a userspace application(thru NF_QUEUE like you said, or
netlink socket, anyway) and then let the application send it out.

The difficulty is that, since I changed the src and dst ip, the mac
address information is totally unavailable. That may be able to
explain the reason why I used skb->dev->hard_start_xmit(...) and then
the kernel crashed.

Is there any way to achieve my goal? Or that is mission impossible?

Wish I've explained clearly enough.

Many thanks for your help indeed!

Best regards,
Gu, Xinxing



2006/4/27, Srinivas G. <srinivasg@esntechnologies.co.in>:
>
> > I've read what you mentioned and since I've done most of the work in
> > kernelspace, I wonder if there is any way to send out the modified
> > packet directly, when of course the mac address is not filled?
>
> I am trying to understand your current situation. So you have a kernel
> module that is subscribed to a certain netfilter hook and as a result
> starts
> receiving packets; and now you want to pass these packets from your
> kernel
> module to a userspace application? Is this correct?
>
> If this is your current situation, you should issue a NF_QUEUE verdict
> for
> arriving packets in your kernel module to queue the packets to
> userspace.
> Subsequently, you will need to create a user space application to
> receive the queued packets and run it. You can use libipq to write a
> userspace
> application that will accept queued packets. See the man page of libipq
> for
> more information on how to do this (the man page contains a fully
> working
> example).
>
> Regards,
> Srinivas G
>
>
