Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbTIDWI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbTIDWI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:08:28 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:57049 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265576AbTIDWIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:08:23 -0400
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jimwclark@ntlworld.com
Cc: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309042251.38514.jimwclark@ntlworld.com>
References: <1062637356.846.3471.camel@cube>
	 <200309042114.45234.jimwclark@ntlworld.com>
	 <Pine.LNX.4.53.0309041723090.9557@chaos>
	 <200309042251.38514.jimwclark@ntlworld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062713213.22634.86.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 23:06:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-04 at 22:51, James Clark wrote:
> I have not proposed a driver model that is compatible with the Windows DDK. 
> This is pure invention from the usual school of 'Windows v Linux, Linux is 
> better because we made it'. The Linux driver model could be much better and 
> hence the OS could escape the niche box it currently is in. Please ask Joe 
> User how he feels about rebuilding his whole OS to add IP6 support to an 
> existing stable system etc.

Joe User got IPV6 from his vendor as a standard component, and if he
didn't the large number of app patches his old distro need outweigh the
kernel.

However for drivers its the same - its a _source_ level interface.

For example 

	spin_lock(&lock)

compiles to different things for uniprocessor/SMP kernels and the
difference is worth real speed. So your binary interface roughly
speaking depends on

-	core options selected
-	compiler (gcc2 v gcc3)
-	SMP v UP
-	Highmem v non highmem
-	CPU target type
-	4G/4G split in 2.6 case

and a few more, while your source interface is pretty stable.

So what does that mean for someone adding a module

1.	It needs compiling
2.	If you want trivial end user ease then you need to wrap the
compilation up as part of the stuff the user never sees.


