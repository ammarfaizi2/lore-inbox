Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWBZXh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWBZXh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWBZXh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:37:28 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:21776 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751423AbWBZXh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:37:27 -0500
Message-ID: <44023B24.9070100@vmware.com>
Date: Mon, 27 Feb 2006 00:35:00 +0100
From: Petr Vandrovec <petr@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OT] Re: Git via a proxy server?
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F022DD553@otce2k03.adaptec.com> <20060223171010.283a9bfe.vsu@altlinux.ru>
In-Reply-To: <20060223171010.283a9bfe.vsu@altlinux.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Feb 2006 23:35:08.0326 (UTC) FILETIME=[47599C60:01C63B2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> On Wed, 22 Feb 2006 10:44:23 -0500 Salyzyn, Mark wrote:
> 
> 
>>Rsync protocol for git is not working for some reason when I pick up the
>>trees; apparently others share my experience. So I switched to the git
>>protocol. I can pick up the trees via git if I am outside Adaptec's
>>network, but inside I need to go through the proxy server.
> 
> 
> I have successfully used transconnect
> (http://sourceforge.net/projects/transconnect) for tunnelling git
> protocol through a HTTP proxy (squid in my case) supporting the CONNECT
> method.
> 
> Git also supports the GIT_PROXY_COMMAND environment variable (or
> core.gitproxy config option), through which you can specify a program to
> be run instead of connecting to a TCP port - then you can use netcat for
> connecting through proxy; however, I have not tried this.

I know I'm comming kinda late, but I'm using:

export GIT_PROXY_COMMAND=/usr/local/bin/proxy-cmd.sh

and proxy-cmd.sh is just single-line command glued from what I found 
available in /bin:

#! /bin/bash

(echo "CONNECT $1:$2 HTTP/1.0"; echo; cat ) | socket 
proxy.ourcompany.com 3128 | (read a; read a; cat )

Replace socket's arguments 'proxy.ourcompany.com 3128' with your http 
proxy.  Fortunately our proxy does not see anything wrong with git's port.
				Best regards,
					Petr Vandrovec
