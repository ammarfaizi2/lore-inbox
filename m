Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWGHVCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWGHVCO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWGHVCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:02:14 -0400
Received: from main.gmane.org ([80.91.229.2]:51880 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030337AbWGHVCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:02:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: ext4 features
Date: Sat, 08 Jul 2006 17:04:47 -0400
Message-ID: <44B01DEF.9070607@tmr.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>	 <20060705125956.GA529@fieldses.org>	 <1152128033.22345.17.camel@lade.trondhjem.org>  <44AC2D9A.7020401@tmr.com> <1152135740.22345.42.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
X-Gmane-NNTP-Posting-Host: mail.tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
In-Reply-To: <1152135740.22345.42.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Wed, 2006-07-05 at 17:22 -0400, Bill Davidsen wrote:
>> Consider the case where the build machine reads source from one network 
>> filesystem and write the binary result to another on another machine. If 
>> you know that I have the kernel source on a file server, do the compiles 
>> on a compute server, and store the binaries on three test machines for 
>> evaluation, you might guess this really can happen. Just increasing the 
>> timestamp may not solve the problem, unless you have a system call to 
>> set timestamp over network f/s, like a high resolution touch.
> 
> If you are running 'touch' manually on all your files, you can always
> arrange to set the timestamp to something more recent. You don't
> normally need a high resolution version of utimes() (and SuSv3 won't
> provide you with one).

No, I didn't quite mean a manual touch, but a system call to "close and 
set time to high resolution" for files where time uniformity is 
important. Consider that in most cases the inodes times are set by the 
host machine clock, which I close the change reflects the fileserving 
host idea of time. If there were a call to close a file and set the 
times like touch, then that could be used, for both local and network files.

Clearly if multiple clients are changing the same file that doesn't 
work, and I doubt that any solution is going to avoid at least some 
undesired side effects.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

