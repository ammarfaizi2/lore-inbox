Return-Path: <linux-kernel-owner+w=401wt.eu-S1030271AbXAKLED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbXAKLED (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 06:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbXAKLED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 06:04:03 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:58235 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030271AbXAKLEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 06:04:01 -0500
Date: Thu, 11 Jan 2007 03:04:00 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] allow setting vm_dirty below 1% for large memory
 machines
In-Reply-To: <17827.22798.625018.673326@notabene.brown>
Message-ID: <Pine.LNX.4.64.0701110245300.22043@twinlark.arctic.org>
References: <17827.22798.625018.673326@notabene.brown>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007, Neil Brown wrote:

> Imagine a machine with lots of memory - say 100Gig.

i've had these problems on machines as "small" as 8GiB.  the real problem 
is that the kernel will let millions of potential (write) IO ops stack up 
for a device which can handle only mere 100s of IOs per second.  (and i'm 
not convinced it does the IOs in a sane order when it has millions to 
choose from)

replacing the percentage based dirty_ratio / dirty_background_ratio with 
sane kibibyte units is a good fix... but i'm not sure it's sufficient.

it seems like the "flow control" mechanism (i.e. dirty_ratio) should be on 
a device basis...

try running doug ledford'd memtest.sh on an 8GiB box with a single disk, 
let it go a few minutes then ^C and type "sync".  i've had to wait 10 
minutes (2.6.18 with default vm settings).

it makes it hard to guarantee a box can shutdown quickly -- nasty for 
setting up UPS on-battery timeouts for example.

-dean
