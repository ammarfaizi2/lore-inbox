Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUALBQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 20:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266059AbUALBQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 20:16:04 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:11337 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S266049AbUALBQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 20:16:02 -0500
Message-ID: <4001F548.3010807@samwel.tk>
Date: Mon, 12 Jan 2004 02:15:52 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@nosferatu.za.org>
CC: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
 0x37ffffff" warning.
References: <Pine.LNX.4.44.0401111242250.20018-100000@bigblue.dev.mdolabs.com> <1073856580.23742.2.camel@nosferatu.lan>
In-Reply-To: <1073856580.23742.2.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:

> Hmm.  Ok, ours is compiled with --enable-64-bit-bfd ...
> might do this?  Bit late now, but I'll try to test
> tomorrow ...

That might definitely do it. offsetT (the type of values in gas) is 
defined as:

typedef bfd_signed_vma offsetT;

That DEFINITELY looks like the bit-size of bfd has an influence. In my 
program, offsetT is 64-bits -- looks like the default for Debian is 
--enable-64-bit-bfd. This explains why I didn't get a warning for my 
custom-built version, but I *did* get it for the version built by 
dpkg-buildpackage. Looks like we've got the final cause of the suddenly 
appearing warning.

-- Bart
