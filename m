Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVCAH4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVCAH4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 02:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVCAH4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 02:56:30 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:1754 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S261279AbVCAH40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 02:56:26 -0500
Message-ID: <42242023.9070101@cosmosbay.com>
Date: Tue, 01 Mar 2005 08:56:19 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: MingJie Chang <mingjie.tw@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: question about sockfd_lookup( )
References: <8b46b8f1050228220257173ddf@mail.gmail.com>
In-Reply-To: <8b46b8f1050228220257173ddf@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Try adding sockfd_put(sock) ;

MingJie Chang wrote:
> Dear all,
> 
> I want to get socket information by the sockfd while accetping,
> 
> so I write a module to test sockfd_lookup(),
> 
> but I got some problems when I test it.
> 
> I hope someone can help me...
> 
> Thank you
> 
> following text is my code and error message
> ===========================================
> === code ===
> 
> int my_socketcall(int call,unsigned long *args)  
> {
>    int ret,err;
>    struct socket * sock;
> 
>    ret = run_org_socket_call(call,args);   //orignal sys_sockcall()
>    
>    if(call==SYS_ACCEPT&&ret>=0) 
>    {
>           sock=sockfd_lookup(ret,&err);
>           printk("lookup done\n");

	if (sock) sockfd_put(sock) ;

>    }
>    return ret;
> }

Eric Dumazet

