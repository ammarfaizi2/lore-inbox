Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVBKC6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVBKC6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 21:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVBKC6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 21:58:31 -0500
Received: from pop.gmx.de ([213.165.64.20]:54728 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262064AbVBKC60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 21:58:26 -0500
X-Authenticated: #26200865
Message-ID: <420C1F9A.3070409@gmx.net>
Date: Fri, 11 Feb 2005 03:59:38 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: EDD failures since edd=off patch
References: <420B6BA8.1040808@gmx.net> <20050210172323.GA29225@lists.us.dell.com>
In-Reply-To: <20050210172323.GA29225@lists.us.dell.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch schrieb:
> On Thu, Feb 10, 2005 at 03:11:52PM +0100, Carl-Daniel Hailfinger wrote:
> 
>>Hi Matt,
>>
>>it seems the edd=off patch has caused some problems with
>>some machines I have access to. They simply don't boot
>>anymore unless I specify edd=foo. foo can be {off,skip,bar}
>>so it seems the hang on boot is related to the parser
>>not finding the parameter it is looking for.
>>I looked through the code some days ago and it seemed to
>>me that the register used to iterate through the command
>>line buffer only got its lower 16 bit reset before calling
>>into the BIOS. I don't have the code handy right now,
>>but I can look later if the hints I gave are insufficient.
> 
> 
> Yes, please.  I'm reading the code, and %ecx gets set to
> (COMMAND_LINE_SIZE-7) which is 256-7=249.  So the upper 24 bits of
> %ecx are going to always be zero, and if "edd=" isn't seen, then %ecx
> will be zero when dropping into edd_mbr_sig_start.  The only other
> register touched is %esi, but it's pushed at the beginning, and pop'd
> on all exit cases, so that should be unchanged.
> 
> ZF is the only other bit I can picture.  On the "no edd= option" path,
> ZF=0 on exit.  With "edd=of" or "edd=sk", ZF=1.  But with "edd=bar",
> ZF=0, which you say works too.  So that's not it...
> 
> CF is taken care of around the int13 calls already, so that's not
> it...

It all boils down to the question: When do the flags set by INCL
differ from those set by CMPW? We have already ruled out CF and ZF,
so only OF, SF, AF, PF can be the culprit.

Looking again, I think it will hang with edd=zz, but I have to verify
that.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
