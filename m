Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTEWJTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbTEWJTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:19:08 -0400
Received: from mail.convergence.de ([212.84.236.4]:35519 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263980AbTEWJTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:19:05 -0400
Message-ID: <3ECDEA97.8070004@convergence.de>
Date: Fri, 23 May 2003 11:32:07 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC][2.5] generic_usercopy() function
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

especially the Video4Linux-driver rely intensively on the 
video_usercopy() function, which handles the copying of userspace 
arguments of ioctls with a simply callback mechanism.

Recently the dvb-core has been added which needs the same function. 
Because of the fact that the core is independent of Video4Linux, the 
code was duplicated to a dvb_usercopy() function.

In order to prevent this code duplication, introducing a 
generic_usercopy() function to lib/ is one possibilty.

The appended 4 patches do the following:

01-introduce.diff:
- remove video_usercopy() from videodev.c
- add generic_usercopy() to "lib/usecopy.c" and update the build system

02-video.diff:
- change all users of video_usercopy() to use generic_usercopy() instead

03-radio.diff:
- change all users of video_usercopy() to use generic_usercopy() instead

04-dvb.diff
- remove dvb_usercopy() from the dvb core and fix it to use 
generic_usercopy() instead.

The diffs are against 2.5.69.

Comments are very appreciated. 8-)
Is there a possibility to get this into the kernel?

CU
Michael.

