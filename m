Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWDQRXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWDQRXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 13:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWDQRXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 13:23:36 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:12554 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751180AbWDQRXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 13:23:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=BGUc1F0v6skqCUr8DgN9GdArNuyR6836hX+DOaFSMXYSVRP3AbMSwaKkNQ558Lb8x0oqroQlKNxluvI2hkQ4dLQ4JhVLUullz2CmzqAO8z9p47teudc9hNhsDkRRhcsEbIxfgoCANWRW3VT3oe9FO8Zhz86D/3iqHruEB2fLOnY=
Message-ID: <4443CF0C.9030102@gmail.com>
Date: Mon, 17 Apr 2006 19:23:24 +0200
From: jordi Vaquero <jordi.vaquero@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Badness in local_bh_enable at kernel/softirq.c:140 with inet_stream
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
First of all, thanks for reply me, but I'm so sorry I not understand
your advice. I'm trying to do a disk driver that connect with a server
using tcp/ip sockets.
I don't understand why the context is the problem I have.
I'm looking for it deeply and I find thaht local_bh_enable is used in
networks, scsi drivers for enable bottom halves.
Sorry if this its in  FAQs, but I don't find it.
Thanks for advance
jordi


On 4/6/06, *linux-os (Dick Johnson)* <linux-os@analogic.com
<mailto:linux-os@analogic.com>> wrote:


    On Thu, 6 Apr 2006, jordi Vaquero wrote:

    > Hello
    >
    > I'm trying to make a Linux Kernel module. My module has a network
    > comunication with sockets, I use the functions like this skeleton,
    >
    >            sd = sock_create(AF_INET,SOCK_STREAM,IPPROTO_TCP,&sock);
    >                if(sd<0){
    >                printk(KERN_ERR "Error\n");
    >            }else{
    >                 sout.sin_family = AF_INET;
    >                err = inet_aton("172.16.151.1
    <http://172.16.151.1>",&sout.sin_addr); //this
    >        function works well, I implemented it.
    >                sout.sin_port = htons(20000);
    >                sd = sock->ops->connect(sock,(struct sockaddr*)&sout,
    >        sizeof(sout),O_RDWR);
    >                if(sd<0){
    >                    printk(KERN_ERR "Error \n");
    >                    sock_release(sock);
    >                }else{
    >                     USE SENDMSG and RECVMSG
    >                        ...
    >                        ...
    >                        ...
    >                   sock_release(sock);
    >                }
    >
    > My problem is that sometimes, at some point near the connect
    function, a
    > warning is launched and dmesg shows this:
    >
    [SNIPPED... Crap]

    This has become a FAQ...
    If you need to do this INSIDE the kernel, you need to do it from
    a kernel thread. Otherwise, your socket is indistinguishable
    from somebody else's open file descriptor. A file descriptor needs
    a CONTEXT! The kernel doesn't have a CONTEXT! You need a process
    to have a context, either a kernel thread or a user-mode task.

    Cheers,
    Dick Johnson
    Penguin : Linux version 2.6.15.4 <http://2.6.15.4> on an i686
    machine (5589.42 BogoMips).
    Warning : 98.36% of all statistics are fiction, book release in April.
    _
    

    ****************************************************************
    The information transmitted in this message is confidential and may
    be privileged.  Any review, retransmission, dissemination, or other
    use of this information by persons or entities other than the
    intended recipient is prohibited.  If you are not the intended
    recipient, please notify Analogic Corporation immediately - by
    replying to this message or by sending an email to
    DeliveryErrors@analogic.com <mailto:DeliveryErrors@analogic.com> -
    and destroy all copies of this information, including any
    attachments, without reading or disclosing them.

    Thank you.



