Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266072AbUFDXOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUFDXOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUFDXMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:12:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56728 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266069AbUFDXI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:08:27 -0400
Date: Sat, 5 Jun 2004 00:08:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz, torvalds@osdl.org
Subject: [RFC] ASLA design, depth of code review and lack thereof
Message-ID: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ladies and gentlemen, may I politely ask what description would fit somebody
who have made the following

        case SNDRV_PCM_FORMAT_FLOAT_BE:
        {
                union {
                        float f;
                        u_int32_t i;
                } u;
                u.f = 0.0;
#ifdef SNDRV_LITTLE_ENDIAN
                return bswap_32(u.i);
#else
                return u.i;
#endif
        }
and quite a few similar, er, wonders an ioctl?

That's right.  This code just has to be in the kernel.  It can't be in
a library, oh no.  It can't be a trivial macro that would result in
compiler generating the constant, no sir - it just had to be proudly
dumped into the great barfbag in the tree.

And that leads to a really interesting question: how many people had ever
read that code?  Or documentation covering that ioctl, while we are at it.

Unless I'm mistaken, ALSA used revision control for a long, long time.
Jaroslav, could you please find the origin of that little wonder and
share with the class - who had done that, why it had been committed into
ALSA tree and how did it manage to survive until the merge into the main
tree?
