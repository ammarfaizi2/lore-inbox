Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281599AbRKVUZA>; Thu, 22 Nov 2001 15:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281609AbRKVUYk>; Thu, 22 Nov 2001 15:24:40 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:17391 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281599AbRKVUYf>; Thu, 22 Nov 2001 15:24:35 -0500
Date: Thu, 22 Nov 2001 20:24:32 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Gavin Baker <gavbaker@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: 2.4.13-ac7 ext3 OOPS
Message-ID: <20011122202432.A11821@redhat.com>
In-Reply-To: <20011118205039.A3208@box.penguin.power>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011118205039.A3208@box.penguin.power>; from gavbaker@ntlworld.com on Sun, Nov 18, 2001 at 08:50:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 18, 2001 at 08:50:39PM +0000, Gavin Baker wrote:
> A seemingly random OOPS while using netscape. 2.4.13-ac7 with preempt patches on a RH7.2 laptop.
 
> Nov 18 13:12:45 n-files kernel: EIP:    0010:[get_hash_table+107/208]    Not tainted

get_hash_table oopses are almost always caused by bad memory.  For
some reason, the buffer cache hashes are peculiarly sensitive to
corruptions.

> Nov 18 13:12:45 n-files kernel: eax: c1430000   ebx: ffffffff   ecx: 00000002   edx: 00003859

It's not enough to be conclusive, but the other common footprint of
random memory corruption is register dumps containing a value which is
all-zeroes except for one flipped bit, like your 0x00000002 value in
%ecx.

Let me know if you can reproduce this, but in the absense of any other
pattern, bad memory is the most likely cause for now.

--Stephen
