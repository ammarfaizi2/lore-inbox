Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVCAKIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVCAKIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 05:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVCAKIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 05:08:37 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:651 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261851AbVCAKI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 05:08:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DcIwEOzhapd1EM8Wm/rGUZbUoiRS+njBnWKBZWql6NrFQruCGV08MYSVbH/AGAcMTK7fQvaSK+z88Sn087322xX21FXzRyNj4Ib83RftUmx5YB9FoUbpH8J2N7Sr+Ako+tfE11vI2fAQeBIGAhfdnjXGzSxLbm2MpMTwPSCal1w=
Message-ID: <8b46b8f10503010208589e7c1f@mail.gmail.com>
Date: Tue, 1 Mar 2005 18:08:00 +0800
From: MingJie Chang <mingjie.tw@gmail.com>
Reply-To: MingJie Chang <mingjie.tw@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: question about sockfd_lookup( )
Cc: Eric Dumazet <dada1@cosmosbay.com>
In-Reply-To: <42242023.9070101@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8b46b8f1050228220257173ddf@mail.gmail.com>
	 <42242023.9070101@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't use sockfd_put(sock)  directly.
I trace its code, the code is 

extern __inline__ void sockfd_put(struct socket *sock)
 {
         fput(sock->file);
}

so I use fput(sock->file)

but it has problems too

1) execute "ls" in the ftp is also block
2) kernel prints "socki_lookup: socket file changed!" 
3) execute "ftp localhost" after rmmod, it will crash

and why the sockfd_put is needed after sockfd_lookup

Thanak again

MingChieh Chang
Taiwan
===============================================

On Tue, 01 Mar 2005 08:56:19 +0100, Eric Dumazet <dada1@cosmosbay.com> wrote:
> Hi
> 
> Try adding sockfd_put(sock) ;
> 
> MingJie Chang wrote:
> > Dear all,
> >
> > I want to get socket information by the sockfd while accetping,
> >
> > so I write a module to test sockfd_lookup(),
> >
> > but I got some problems when I test it.
> >
> > I hope someone can help me...
> >
> > Thank you
> >
> > following text is my code and error message
> > ===========================================
> > === code ===
> >
> > int my_socketcall(int call,unsigned long *args)
> > {
> >    int ret,err;
> >    struct socket * sock;
> >
> >    ret = run_org_socket_call(call,args);   //orignal sys_sockcall()
> >
> >    if(call==SYS_ACCEPT&&ret>=0)
> >    {
> >           sock=sockfd_lookup(ret,&err);
> >           printk("lookup done\n");
> 
>         if (sock) sockfd_put(sock) ;
> 
> >    }
> >    return ret;
> > }
> 
> Eric Dumazet
> 
>
