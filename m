Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbUBINaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUBINaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:30:13 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:24521 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S265217AbUBINaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:30:07 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
Date: Mon, 9 Feb 2004 14:29:43 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [matroxfb] Second head is on but fb1 not accessible
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <32704C258F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Feb 04 at 14:21, Jan Mynarik wrote:
> > Make sure that /dev/fb1 is character device 29,1 and not 29,32. 2.2.x kernels
> > accept 29,32 only, 2.4.x accept both, and 2.6.x accept 29,1 only.
> 
> Thanks for super-fast reply :-), I did think it could be related to
> minor device number.
> 
> But anyway, shouldn't I have at least console visible on the second head
> (even if /dev/fb1 is not accessible)? I tested it by attaching my
> monitor to second head and nothing appeared.

Only G450/G550 display same picture (from CRTC1) on all outputs, MAVEN output
is by default disabled until you'll configure it with 'matroxset'. 
If you want same picture on both outputs even for G400, it should be 
enough to replace

ACCESS_FBINFO(outputs[1]).src = MATROXFB_SRC_NONE;

with

ACCESS_FBINFO(outputs[1]).src = MATROXFB_SRC_CRTC1;

in maven_init_client() in drivers/video/matrox/matroxfb_maven.c.
(it is not enabled by default as on G400 you can have either Maven output
or DFP output but not both; G450/G550 does not have such restriction,
and so on G450/G550 all three outputs show same picture by default).
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    

