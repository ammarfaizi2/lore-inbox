Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVC1LST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVC1LST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 06:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVC1LST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 06:18:19 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:40970 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261522AbVC1LSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 06:18:14 -0500
Date: Mon, 28 Mar 2005 13:19:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMBOL question
Message-ID: <20050328111953.GA20502@mars.ravnborg.org>
References: <4247E62B.5080900@euroweb.net.mt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4247E62B.5080900@euroweb.net.mt>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 01:10:35PM +0200, Josef E. Galea wrote:
> Hi,
> 
> I have 2 modules. The first one uses EXPORT_SYMBOL to make some function 
> available to other modules. These prototypes for these functions were 
> also put in a header file. Now the second module uses the functions the 
> functions defined in the first module by and includes the afore 
> mentioned header file. However when i'm compiling the module, I get a 
> symbol underfined warning. When I load the module it works as expected. 
> Is there any way to get rid of these warnings.
> 
> Another problem I'm having is that when I load the second module I get 
> `no version for "rbnode_initialize" found: kernel tainted.' 
> (rbnode_initialize is one of the functions exported by the first 
> module). Both MODULE_LICENSE("GPL"); and MODULE_VERSION are declared in 
> the two modules. Is there anything I'm missing?

You need to compile both modules at the same time.
Do something like this for your two modules foo and bar:

modules/Makefile
obj-y := foo/ bar/
modules/foo/	<= Your foo module
modules/bar/	<= Your bar module

Then when building the modules stay in modules/ and
execute:
make -C <path-to-kernel-src> M=`pwd`

And to install modules:
make -C <path-to-kernel-src> M=`pwd` modules_install

	Sam
