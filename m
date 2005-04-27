Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVD0CXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVD0CXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 22:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVD0CXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 22:23:12 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:59010 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261890AbVD0CXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 22:23:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RmXTt7luyWsWpZgIXZEZo669z1IYXPwVZEtupuzRdACg9xuXKe40qNdlNPbHZSs82T5W0KnZhdcne68KQmHH/XuuNrlUZi8aiBosNXcos8KstyO2biwpHRx+V8snEQBQ8t7aJNm0W1dljgdlaVVRibRZe1RVlyGLr1uBRL3tBrE=
Message-ID: <426EF781.6040403@gmail.com>
Date: Wed, 27 Apr 2005 11:22:57 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 01/04] scsi: make scsi_send_eh_cmnd use
 its own timer instead of scmd->eh_timeout
References: <20050419143100.E231523D@htj.dyndns.org>	 <20050419143100.0F9A8C3B@htj.dyndns.org>	 <1114381342.4786.17.camel@mulgrave>  <426C2FC3.4090105@gmail.com> <1114452544.5000.11.camel@mulgrave>
In-Reply-To: <1114452544.5000.11.camel@mulgrave>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Mon, 2005-04-25 at 08:46 +0900, Tejun Heo wrote:
> 
>>  If you're talking about scmd->eh_timeout, it's our main timer for 
>>normal command timeouts.  If you're suggesting renaming it to something 
>>more apparant, I agree.  Maybe just scmd->timeout will do.
> 
> 
> Sorry ... actually on the ball now; I was assuming you simply wanted not
> to use the field for efficiency.  
> 
> So, actually having read the description, you think that reusing the
> eh_timeout in the error handler command submission path could confuse
> the normal done routine if the host still has the command pending and
> completes it?

 Hi, James.

 Sorry about late reply.  Been busy and currently on the run, so please
excuse me for being brief.

 * A command is passed to lldd and starts execution
 * It times out.
 * eh runs
 * abort isn't implemented or fails
 * eh issues eh cmd (TUL, STU...)
 * The command miraculously & stupidly completes just now.
 * The lldd succeeds to delete timer and normal completion path runs.
 * We're fucked up now.

 If anything is wrong, please point out.

 Thanks.  Gotta go.

-- 
tejun
