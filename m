Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWE0DDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWE0DDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 23:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWE0DDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 23:03:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6865 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750806AbWE0DDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 23:03:03 -0400
Date: Fri, 26 May 2006 23:03:02 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: .17rc5 cfq slab corruption.
Message-ID: <20060527030302.GB7165@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060526213915.GB7585@redhat.com> <20060527025623.GA7165@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060527025623.GA7165@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 10:56:23PM -0400, Dave Jones wrote:
 > On Fri, May 26, 2006 at 05:39:15PM -0400, Dave Jones wrote:
 >  > Was playing with googles new picasa toy, which hammered the disks
 >  > hunting out every image file it could find, when this popped out:
 >  > 
 >  > Slab corruption: (Not tainted) start=ffff810012b998c8, len=168
 >  > Redzone: 0x5a2cf071/0x5a2cf071.
 >  > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
 >  > 090: 10 bd 28 1b 00 81 ff ff 6b 6b 6b 6b 6b 6b 6b 6b
 >  > Prev obj: start=ffff810012b99808, len=168
 >  > Redzone: 0x5a2cf071/0x5a2cf071.
 >  > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
 >  > 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 >  > 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 >  > Next obj: start=ffff810012b99988, len=168
 >  > Redzone: 0x5a2cf071/0x5a2cf071.
 >  > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
 >  > 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 >  > 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 > 
 > After a reboot, I just hit this again.  This time whilst the box was
 > mostly idle (just picking up some email via fetchmail)
 > 
 > Slab corruption: (Not tainted) start=ffff81003dcde8c8, len=168
 > Redzone: 0x5a2cf071/0x5a2cf071.
 > Last user: [<ffffffff8032bb5f>](cfq_free_io_context+0x2f/0x74)
 > 090: d0 1a 65 3b 00 81 ff ff 6b 6b 6b 6b 6b 6b 6b 6b
 > Prev obj: start=ffff81003dcde808, len=168
 > Redzone: 0x170fc2a5/0x170fc2a5.
 > Last user: [<ffffffff8021ce1c>](cfq_set_request+0x3bb/0x41f)
 > 000: 00 00 00 00 00 00 00 00 01 00 00 00 5a 5a 5a 5a
 > 010: 00 00 00 00 00 00 00 00 08 78 44 3c 00 81 ff ff
 > Next obj: start=ffff81003dcde988, len=168
 > Redzone: 0x170fc2a5/0x170fc2a5.
 > Last user: [<ffffffff8021ce1c>](cfq_set_request+0x3bb/0x41f)
 > 000: 88 e6 cd 3d 00 81 ff ff 00 00 00 00 5a 5a 5a 5a
 > 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > 
 > 
 > What's interesting is the 00 81 ff ff part of the corruption
 > is there in both cases.  Anyone have any clues what this could be?

<sudden realisation> oh, it's high 32 bits of the address, duh.
Back to head-scratching.

		Dave

-- 
http://www.codemonkey.org.uk
