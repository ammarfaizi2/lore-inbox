Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbUHRNLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUHRNLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 09:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUHRNHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 09:07:48 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:10876 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S266244AbUHRNFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 09:05:35 -0400
Message-ID: <41235417.9080602@microgate.com>
Date: Wed, 18 Aug 2004 08:05:27 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8.1-mm1 Tty problems?
References: <2a4f155d040817070854931025@mail.gmail.com>	 <412271EF.6040201@microgate.com> <1092831738.26566.68.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1092831738.26566.68.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:
> I find that puzzling, given that flush_unauthorized_files is only called
> if the process is changing SIDs on exec, and running less certainly
> doesn't involve a SID transition (at least for any policy that I have
> seen).  I tried the sequence shown with 2.6.8.1-mm1 with SELinux enabled
> and disabled, and did not see the behavior he describes.  Is the bug
> reproducible?  Was he running with SELinux enabled or disabled?  What
> policy did he have loaded?

According to Ismail:
* The problem is reproducible.
* SELinux is disabled.
* With the patch the problem occurs.
* With the patch reversed, the problem went away.

Unfortunately, this appears to be mixed up with
another 2.6.8.1-mm1 change causing udev to garble
the creation of /dev/tty and pty devices.

Applying/reversing the controlling-tty patch in isolation
creates/corrects the symptom with the less program,
so there seems to be some relation.

--
Paul Fulghum
paulkf@microgate.com
