Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVHIIJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVHIIJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 04:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVHIIJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 04:09:44 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:60065 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932464AbVHIIJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 04:09:43 -0400
Date: Tue, 9 Aug 2005 10:09:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: James Morris <jmorris@namei.org>
cc: "Theodore Ts'o" <tytso@mit.edu>,
       David Wagner <daw-usenet@taverner.CS.Berkeley.EDU>,
       linux-kernel@vger.kernel.org
Subject: Re: understanding Linux capabilities brokenness
In-Reply-To: <Pine.LNX.4.63.0508090044400.20178@excalibur.intercode>
Message-ID: <Pine.LNX.4.61.0508090822000.1805@yvahk01.tjqt.qr>
References: <20050808211241.GA22446@clipper.ens.fr> <20050808223238.GA523@clipper.ens.fr>
 <dd8r9s$eqn$1@taverner.CS.Berkeley.EDU> <20050809015048.GA14204@thunk.org>
 <Pine.LNX.4.63.0508090044400.20178@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


Ts'o wrote:
>since _obviously_ when root calls setuid(), it never fails, right?

Well this really depends on how privileged a certain root user (think of 
SELinux and others) is.

>(2) There was some debate about whether or not this method was the              
course of wisdom,

James Morris wrote:
>Should we be thinking about deprecating and removing capabilities from 
>Linux?

My one half says no. But it needs reworking. Just look what I had to do 
with the linux source code in order to get this
< ftp://ftp.gwdg.de/linux/misc/suser-jengelh/multiadm-1.0.tbz2 > to work as 
intended - I had to poke really hard on caps stuff to get this module done.

And my other half says yes, because it's ironically to give a user all caps 
and then limit a certain user's permissions using LSM hook functions. So in 
effect, if you wanted root accounts of varying powers, all of them would need 
some - or even all - caps so that the code flow can reach the security_*() 
functions at all, because capable() is done before security_*(). So to get to 
security_*(), caps must be enabled, which turns a

	if(!capable(CAP_DAC_OVERRIDE)) return;

into, effectively,

	if(0) return;

With regard to _this_, I think it would be best to kill the cap checks, and 
let a security_* function handle it, in the style of "security/traditional.c".


Jan Engelhardt
-- 
