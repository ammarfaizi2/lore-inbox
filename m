Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWJMRzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWJMRzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWJMRzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:55:44 -0400
Received: from terminus.zytor.com ([192.83.249.54]:42637 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751402AbWJMRzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:55:43 -0400
Message-ID: <452FD305.6070902@zytor.com>
Date: Fri, 13 Oct 2006 10:55:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Kay Sievers <kay.sievers@vrfy.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.19-rc2
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <200610131840.28411.s0348365@sms.ed.ac.uk>
In-Reply-To: <200610131840.28411.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Friday 13 October 2006 17:49, Linus Torvalds wrote:
>> Ok, it's a week since -rc1, so -rc2 is out there.
> 
> Does anybody know what's up with the git server? Hopefully it's just my 
> connection...
> 
> [alistair] 18:38 [~/linux-git] git pull
> fatal: unexpected EOF
> Fetch failure: 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 

No, this is the result of a serious problem with gitweb.

We run gitweb behind a cache (otherwise it would be unacceptably 
expensive), but when httpd starts timing out on gitweb, it spawns gitweb 
over and over and over again, and the load on the machine skyrockets, 
throttling other services.

This happens every time we're on one server instead of two (one server 
is down right now for network rewiring.)

I think for now I'm just going to put a loadavg cap on running gitweb...

	-hpa
