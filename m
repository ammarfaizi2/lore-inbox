Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751958AbWIGUFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbWIGUFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 16:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWIGUFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 16:05:46 -0400
Received: from code.and.org ([65.172.155.230]:42447 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id S1751958AbWIGUFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 16:05:45 -0400
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
From: James Antill <james@and.org>
References: <20060905212643.GA13613@clipper.ens.fr>
	<m3r6yn4jxg.fsf@code.and.org>
	<ED485CED-AE69-466E-876C-2CC9DADC5576@mac.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 07 Sep 2006 16:05:40 -0400
In-Reply-To: <ED485CED-AE69-466E-876C-2CC9DADC5576@mac.com> (Kyle Moffett's message of "Thu, 7 Sep 2006 14:33:56 -0400")
Message-ID: <m3mz9b4f3f.fsf@code.and.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: james@mail.and.org
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
X-SA-Exim-Version: 4.2 (built Tue, 02 May 2006 07:36:10 -0400)
X-SA-Exim-Scanned: Yes (on mail.and.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> On Sep 07, 2006, at 14:21:15, James Antill wrote:
>>
>> Just a minor comment, can you break out the OPEN into at least
>> OPEN_R, OPEN_NONFILE_W and OPEN_W (possibly OPEN_A, but I don't
>> want that personally). The case I'm thinking about are network
>> daemons that need to open+write to the syslog socket but only have
>> read access elsewhere.
>>
>> Also there is much more than just bind9 using capabilities, the
>> obvious ones that come to mind are NOATIME and AUDIT.
>
> To be honest, once you get to the point of having an OPEN_NONFILE_W
> capability you should really just be using SELinux.

 Actually, I got confused ... I forgot that you have to connect() to
/dev/log and can't just open() it[1] ... so just having open_r and
open_w separated would be enough. Which you'll hopefully agree would
be nice to have outside of SELinux policy (noting that SELinux doesn't
let you limit open calls, as such, only read+write -- although it's
mostly the same).


[1] Although, if we ever fix open... :)

-- 
James Antill -- james@and.org
http://www.and.org/and-httpd
