Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVD0Lu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVD0Lu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 07:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVD0Luz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 07:50:55 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:808 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261476AbVD0Luq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 07:50:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OLpDmmiPTj+sAi96817e+cj/aD5rlR2Wm49PDN9cNBxaUb1eqUW3+bF1LqXCQjB/wHsKjAiNnb43JxdKzdXQm7g5krlu2wRsGtFLjPISL3UGYE8n+39MepvOW0s6xKLvyLO+N9wY7dUWY3+Ih+TBpR4l8++Xk82qQHWIYYb71kA=
Message-ID: <426F7C8F.8010105@gmail.com>
Date: Wed, 27 Apr 2005 20:50:39 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 01/04] scsi: make scsi_send_eh_cmnd use
 its own timer instead of scmd->eh_timeout
References: <20050419143100.E231523D@htj.dyndns.org>	 <20050419143100.0F9A8C3B@htj.dyndns.org>	 <1114381342.4786.17.camel@mulgrave>  <426C2FC3.4090105@gmail.com>	 <1114452544.5000.11.camel@mulgrave>  <426EF781.6040403@gmail.com> <1114580059.5039.6.camel@mulgrave>
In-Reply-To: <1114580059.5039.6.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello, James.

James Bottomley wrote:
> On Wed, 2005-04-27 at 11:22 +0900, Tejun Heo wrote:
> 
>> * A command is passed to lldd and starts execution
>> * It times out.
>> * eh runs
>> * abort isn't implemented or fails
>> * eh issues eh cmd (TUL, STU...)
>> * The command miraculously & stupidly completes just now.
> 
> 
> This should be impossible.  The error handler API requirement is that
> the driver relinquish a command once it returns success from any error
> handling callback ... and if it never returns success, we simply offline
> the device and never use it again.  This is the principle behind the
> command reuse: we only try an additional command *after* error handling
> succeeds, so the error handler now owns the command absolutely.
> 

  Hmmm, yeah, it currently cannot happen, and if what you're describing 
is a requirement, everything should be okay.  But, I still think that 
using separate timer will be better as it won't add any overhead (with 
the change you proposed) and it makes the somewhat unobivous requirement 
go away.  Or at least add BUG_ON() test or something to make the 
requirement clear.

  What do you think?

  Thanks.

-- 
tejun
