Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBOMX6>; Thu, 15 Feb 2001 07:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbRBOMXs>; Thu, 15 Feb 2001 07:23:48 -0500
Received: from pcow025o.blueyonder.co.uk ([195.188.53.125]:60431 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S129106AbRBOMXe>;
	Thu, 15 Feb 2001 07:23:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Compaq Alpha: missing i-cache invalidates in ptrace (2.2.18, 2.4.0) ?
Reply-To: James Cownie <jcownie@etnus.com>
Date: Thu, 15 Feb 2001 12:23:27 +0000
From: James Cownie <jcownie@etnus.com>
Message-ID: <14TNRY-4xc-00@etnus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been seeing some peculiar effects on Alpha boxes (particularly on
SMPs) where threads run right past breakpoints planted by a debugger.
(This on 2.2 series kernels).

Looking at the code in arch/alpha/kernel/ptrace.c there appears to be
nowhere where flush_icache_range is called. According to the Alpha
architecture manual you must execute a "call_pal imb" (which is what
flush_icache_range turns into) after changing the I-stream.

So :-

1) Anyone agree with me that flush_icache_range ought to be called
   after any ptrace write which modifies an executable page ?
   (Or have I missed something which has this effect ?)

2) If so, would patches be accepted ?

The same problem also appears to exist in 2.4...

Thanks

-- Jim 

James Cownie	<jcownie@etnus.com>
Etnus, LLC.     +44 117 9071438
http://www.etnus.com

