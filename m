Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUH0J4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUH0J4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUH0J4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:56:43 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:56212 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261426AbUH0J4l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:56:41 -0400
Date: Fri, 27 Aug 2004 11:56:40 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: TCP listen()/accept() bug for unbound sockets?
Message-ID: <20040827095640.GA27286@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.27,

while investigating the xv_bmpslap XV exploit posted to bugtraq I got this
strace which revealed that it seems possible to listen() and accept()
on unbound TCP sockets. The bind() failed and the process appeared to
be listening on a random port in the ip_local_port_range and connected
successfully:

24876 socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 4
24876 bind(4, {sa_family=AF_INET, sin_port=htons(7000), sin_addr=inet_addr("0.0.0.0")}, 16) = -1 EADDRINUSE (Address already in use)
24876 listen(4, 1)                      = 0
24876 accept(4, 0, NULL)                = 5
24876 dup2(5, 0)                        = 0
24876 dup2(5, 1)                        = 1
24876 dup2(5, 2)                        = 2
24876 execve("/bin//sh", ["/bin//sh"], [/* 0 vars */]) = 0

is this defined behavior?




-- 
Frank
