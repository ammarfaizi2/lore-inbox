Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUHWUmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUHWUmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUHWUka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:40:30 -0400
Received: from mail.tmr.com ([216.238.38.203]:35087 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267490AbUHWUYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:24:55 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Mon, 23 Aug 2004 16:25:17 -0400
Organization: TMR Associates, Inc
Message-ID: <cgdjek$klh$1@gatekeeper.tmr.com>
References: <m37jrr40zi.fsf@zoo.weinigel.se><m37jrr40zi.fsf@zoo.weinigel.se> <20040822192646.GH19768@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093292308 21169 192.168.12.100 (23 Aug 2004 20:18:28 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040822192646.GH19768@thundrix.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre wrote:

> Well, for that it might be  a nice feature to register and delete such
> filters  online, using  a  register/remove_scsi_filter interface,  but
> well, otoh that might be undesirable security-wise.

Let me throw out two ideas to see if anyone find them useful.

1 - loadable command filters in the kernel.

Each device could have a filter set, which could be empty to require 
RAWIO capability, or set to a kernel default. Access could be made to 
modify a filter via proc, sysfs, or ioctl. The set method is not 
relevant to the idea.

2 - a filter program.

This one can be done right now, no kernel mod needed. A program with 
appropriate permissions can be started, and will create a command/status 
fifo pair with permissions which allow only programs with group 
permission to open. This allows the admin to put in any filter desired, 
know about vendor commands, etc. It also allows various security setups, 
the group can be on the user (trusted users) or on a setgid program 
(which limits the security issues).

Note that the permissions on individual devices need not be the same; I 
can have one group for disk, another for CD/DVD. You caould even be anal 
and have the filter time sensitive, etc.

A 'standard" place for the fifos helps portability, /var/sgio/dev/hda 
might be a directory, with fifos command and status.


Okay, did I miss something, or can this be solved without any additional 
kernel hacks?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
